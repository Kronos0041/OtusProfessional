//
//  ContentView.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.
//

import SwiftUI

struct ContentView: View {
    let quotesService: QuotesService?

    init(quotesService: QuotesService? = nil) {
        self.quotesService = quotesService
    }

    var body: some View {
        VStack {
            AnimeChanRootView(quotesService: quotesService)
        }
    }
}

#Preview {
    ContentView(quotesService: MockQuotesService())
}
