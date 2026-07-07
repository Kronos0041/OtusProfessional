//
//  AnimeChanRootView.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.

import SwiftUI
import AnimechanAPI

struct AnimeChanRootView: View {
    private let quotesService: QuotesService

    @State private var path: [AnimeRoute] = []

    init(quotesService: QuotesService) {
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
            AnimeQuoteDetailScreen(
                quote: route.quote,
                depth: route.depth,
                path: $path,
                quotesService: quotesService
            )
        }
    }
}

#Preview {
    AnimeChanRootView(quotesService: MockQuotesService())
}
