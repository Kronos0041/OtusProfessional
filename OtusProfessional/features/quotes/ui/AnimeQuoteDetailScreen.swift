//
//  AnimeQuoteDetailScreen.swift
//  OtusProfessional
//
//  Created by Alex on 28.06.2026.
//

import SwiftUI
import AnimechanAPI


internal struct AnimeQuoteDetailScreen: View {
    let quote: AnimechanQuote
    let depth: Int
    @Binding var path: [AnimeRoute]

    @StateObject private var store: Store<QuotesState, QuotesAction>
    @State private var flyingQuote: AnimechanQuote?
    @State private var flightProgress = false

    init(
        quote: AnimechanQuote,
        depth: Int,
        path: Binding<[AnimeRoute]>,
        quotesService: QuotesService?
    ) {
        let resolvedQuotesService = quotesService
            ?? ServiceLocator.shared.resolve(QuotesServiceImpl.self)
            ?? QuotesServiceImpl()

        self.quote = quote
        self.depth = depth
        _path = path
        _store = StateObject(wrappedValue: Store(
            initial: QuotesState(
                context: .related(anime: quote.anime.name, character: quote.character.name),
                excludedQuoteID: quote.id
            ),
            reducer: quotesReducer,
            middlewares: [quotesMiddleware(service: resolvedQuotesService)]
        ))
    }

    var body: some View {
        VStack(spacing: QuotesConstants.Layout.zeroSpacing) {
            AnimeNavigationBar(title: "Цитата", canGoBack: true) {
                path.removeLast()
            }

            Picker("Рубрика", selection: rubricBinding) {
                ForEach(QuotesRubric.allCases) { rubric in
                    Text(rubric.title).tag(rubric)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.bottom, QuotesConstants.Layout.segmentedBottomPadding)

            content
        }
        .background(Color(.systemGroupedBackground))
        .overlay(alignment: .topLeading) {
            if let flyingQuote {
                AnimeQuoteRow(quote: flyingQuote)
                    .padding(.horizontal)
                    .offset(
                        x: flightProgress ? QuotesConstants.FlightAnimation.finalOffsetX : .zero,
                        y: flightProgress ? QuotesConstants.FlightAnimation.finalOffsetY : QuotesConstants.FlightAnimation.detailInitialOffsetY
                    )
                    .scaleEffect(flightProgress ? QuotesConstants.FlightAnimation.finalScale : QuotesConstants.FlightAnimation.initialScale)
                    .rotationEffect(.degrees(flightProgress ? QuotesConstants.FlightAnimation.finalRotationDegrees : QuotesConstants.FlightAnimation.initialRotationDegrees))
                    .opacity(flightProgress ? QuotesConstants.FlightAnimation.finalOpacity : QuotesConstants.FlightAnimation.initialOpacity)
                    .allowsHitTesting(false)
            }
        }
        .onAppear {
            store.dispatch(.screenAppeared)
        }
    }

    private var rubricBinding: Binding<QuotesRubric> {
        Binding(
            get: { store.state.rubric },
            set: { store.dispatch(.selectRubric($0)) }
        )
    }

    @ViewBuilder
    private var content: some View {
        if store.state.viewMode == .loading, store.state.quotes.isEmpty {
            List {
                quoteSection

                Section(store.state.subtitle) {
                    HStack {
                        Spacer()
                        ActivityIndicatorRepresentable(isAnimating: .constant(true))
                        Spacer()
                    }
                }
            }
            .listStyle(.insetGrouped)
        } else if let message = store.state.errorMessage, store.state.quotes.isEmpty {
            List {
                quoteSection

                Section(store.state.subtitle) {
                    ContentUnavailableView(
                        "Не удалось загрузить цитаты",
                        systemImage: "exclamationmark.triangle",
                        description: Text(message)
                    )
                }
            }
            .listStyle(.insetGrouped)
        } else {
            List {
                quoteSection

                Section {
                    ForEach(store.state.visibleQuotes) { quote in
                        AnimeQuoteRow(quote: quote)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                select(quote)
                            }
                            .onAppear {
                                store.dispatch(.quoteAppeared(quote.id))
                            }
                    }

                    if store.state.isLoadingPage {
                        HStack {
                            Spacer()
                            ActivityIndicatorRepresentable(
                                isAnimating: .constant(true),
                                style: .medium
                            )
                            Spacer()
                        }
                    }
                } header: {
                    Text(store.state.subtitle)
                } footer: {
                    if !store.state.canLoadNextPage {
                        Text("Больше цитат для этой рубрики нет.")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .refreshable {
                store.dispatch(.reload)
            }
        }
    }

    private var quoteSection: some View {
        Section {
            Text(quote.content)
                .font(.title3.weight(.semibold))
                .padding(.vertical, QuotesConstants.Layout.quoteSectionVerticalPadding)

            Label(quote.anime.name, systemImage: "film")
            Label(quote.character.name, systemImage: "person.crop.circle")
        }
    }

    private func select(_ quote: AnimechanQuote) {
        flyingQuote = quote
        flightProgress = false

        withAnimation(.easeInOut(duration: QuotesConstants.FlightAnimation.duration)) {
            flightProgress = true
        } completion: {
            guard path.count < QuotesConstants.Navigation.maximumPathCount else {
                flyingQuote = nil
                flightProgress = false
                return
            }

            withAnimation {
                path.append(.quoteDetail(quote, depth: depth + QuotesConstants.Navigation.depthStep))
            }

            flyingQuote = nil
            flightProgress = false
        }
    }
}
