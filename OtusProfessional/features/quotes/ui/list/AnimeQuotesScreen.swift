//
//  AnimeQuotesScreen.swift
//  OtusProfessional
//
//  Created by Alex on 28.06.2026.
//

import SwiftUI
import AnimechanAPI
import OtusUI

internal struct AnimeQuotesScreen: View {
    @Binding private var path: [AnimeRoute]

    @StateObject private var store: Store<QuotesState, QuotesAction>
    @State private var flyingQuote: AnimechanQuote?
    @State private var flightProgress = false
    private let depth: Int
    
    
    private var rubricBinding: Binding<QuotesRubric> {
        Binding(
            get: { store.state.rubric },
            set: { store.dispatch(.selectRubric($0)) }
        )
    }

    private var queryDialogPresentedBinding: Binding<Bool> {
        Binding(
            get: { store.state.isQueryDialogPresented },
            set: { isPresented in
                if !isPresented {
                    store.dispatch(.cancelQueryDialog)
                }
            }
        )
    }

    private var queryDraftBinding: Binding<String> {
        Binding(
            get: { store.state.queryDraft },
            set: { store.dispatch(.updateQueryDraft($0)) }
        )
    }

    init(
        context: QuotesContext,
        depth: Int,
        path: Binding<[AnimeRoute]>,
        quotesService: QuotesService
    ) {
        self.depth = depth
        _path = path
        _store = StateObject(wrappedValue: Store(
            initial: QuotesState(context: context),
            reducer: quotesReducer,
            middlewares: [quotesMiddleware(service: quotesService)]
        ))
    }

    var body: some View {
        VStack(spacing: QuotesConstants.Layout.zeroSpacing) {
            AnimeNavigationBar(title: store.state.title, canGoBack: depth > QuotesConstants.Navigation.rootDepth) {
                path.removeLast()
            }

            Picker(SwiftGen.Quotes.Category.title, selection: rubricBinding) {
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
        .overlay(alignment: .bottomTrailing) {
            QuotesFloatingAddButton(accessibilityLabel: SwiftGen.Quotes.Action.addRequest) {
                store.dispatch(.showQueryDialog)
            }
            .padding(.trailing, QuotesConstants.Layout.floatingButtonTrailingPadding)
            .padding(.bottom, QuotesConstants.Layout.floatingButtonBottomPadding)
        }
        .overlay(alignment: .topLeading) {
            if let flyingQuote {
                AnimeQuoteRow(quote: flyingQuote)
                    .padding(.horizontal)
                    .offset(
                        x: flightProgress ? QuotesConstants.FlightAnimation.finalOffsetX : .zero,
                        y: flightProgress ? QuotesConstants.FlightAnimation.finalOffsetY : QuotesConstants.FlightAnimation.listInitialOffsetY
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
        .alert(store.state.dialogTitle, isPresented: queryDialogPresentedBinding) {
            TextField(store.state.dialogPlaceholder, text: queryDraftBinding)

            Button(SwiftGen.Common.cancel, role: .cancel) {
                store.dispatch(.cancelQueryDialog)
            }

            Button(SwiftGen.Common.ok) {
                store.dispatch(.confirmQueryDialog)
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        if store.state.viewMode == .loading, store.state.quotes.isEmpty {
            ActivityIndicatorRepresentable(isAnimating: .constant(true))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let message = store.state.errorMessage, store.state.quotes.isEmpty {
            ContentUnavailableView(
                SwiftGen.Quotes.Error.loadFailed,
                systemImage: "exclamationmark.triangle",
                description: Text(message)
            )
        } else {
            List {
                Section {
                    ForEach(store.state.quotes) { quote in
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
                        Text(SwiftGen.Quotes.Footer.noMoreQuotes)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .refreshable {
                store.dispatch(.reload)
            }
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
                path.append(AnimeRoute(
                    quote: quote,
                    depth: depth + QuotesConstants.Navigation.depthStep
                ))
            }

            flyingQuote = nil
            flightProgress = false
        }
    }
}
