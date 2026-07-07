//
//  QuotesFloatingAddButton.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import SwiftUI

struct QuotesFloatingAddButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white)
                .frame(
                    width: QuotesConstants.FloatingButton.size,
                    height: QuotesConstants.FloatingButton.size
                )
                .background(.tint, in: Circle())
                .shadow(
                    color: .black.opacity(QuotesConstants.FloatingButton.shadowOpacity),
                    radius: QuotesConstants.FloatingButton.shadowRadius,
                    x: QuotesConstants.FloatingButton.shadowOffsetX,
                    y: QuotesConstants.FloatingButton.shadowOffsetY
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(Strings.Quotes.Action.addRequest)
    }
}
