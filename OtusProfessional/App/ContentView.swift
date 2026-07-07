//
//  ContentView.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.
//

import SwiftUI

struct ContentView: View {
    private let quotesService: QuotesService

    init(quotesService: QuotesService) {
        self.quotesService = quotesService
    }

    var body: some View {
        AnimeChanRootView(quotesService: quotesService)
    }
}

#Preview {
    ContentView(quotesService: MockQuotesService())
}
