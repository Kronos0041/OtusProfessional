//
//  AnimeQuoteRow.swift
//  OtusProfessional
//
//  Created by Alex on 28.06.2026.
//

import SwiftUI
import AnimechanAPI

internal struct AnimeQuoteRow: View {
    private let quote: AnimechanQuote

    init(quote: AnimechanQuote) {
        self.quote = quote
    }

    var body: some View {
        VStack(alignment: .leading, spacing: QuotesConstants.QuoteRow.verticalSpacing) {
            Text(quote.content)
                .font(.body)
                .foregroundStyle(.primary)
                .lineLimit(QuotesConstants.QuoteRow.contentLineLimit)

            HStack(spacing: QuotesConstants.QuoteRow.metadataSpacing) {
                Label(quote.anime.name, systemImage: "film")
                    .lineLimit(QuotesConstants.QuoteRow.metadataLineLimit)
                Spacer(minLength: QuotesConstants.QuoteRow.metadataSpacerMinLength)
                Label(quote.character.name, systemImage: "person")
                    .lineLimit(QuotesConstants.QuoteRow.metadataLineLimit)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, QuotesConstants.QuoteRow.verticalPadding)
    }
}
