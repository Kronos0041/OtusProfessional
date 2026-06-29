//
//  AnimeChanRootView.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.

import SwiftUI
import AnimechanAPI

struct AnimeChanRootView: View {
    let quotesService: QuotesService?

    @State private var path: [AnimeRoute] = []

    init(quotesService: QuotesService? = nil) {
        self.quotesService = quotesService
    }

    var body: some View {
        CustomNavigationStack(path: $path) {
            AnimeQuotesScreen(
                context: .default,
                depth: QuotesConstants.Navigation.rootDepth,
                path: $path,
                quotesService: quotesService
            )
        } destination: { route in
            switch route {
            case let .quoteDetail(quote, depth):
                AnimeQuoteDetailScreen(
                    quote: quote,
                    depth: depth,
                    path: $path,
                    quotesService: quotesService
                )
            }
        }
    }
}

#Preview {
    AnimeChanRootView(quotesService: MockQuotesService())
}
