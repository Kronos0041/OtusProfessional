//
//  AnimeNavigationBar.swift
//  OtusProfessional
//
//  Created by Alex on 28.06.2026.
//

import SwiftUI

struct AnimeNavigationBar: View {
    let title: String
    let canGoBack: Bool
    let onBack: () -> Void

    var body: some View {
        HStack {
            if canGoBack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .frame(
                            width: QuotesConstants.Navigation.barButtonSize,
                            height: QuotesConstants.Navigation.barButtonSize
                        )
                }
            } else {
                Color.clear.frame(
                    width: QuotesConstants.Navigation.barButtonSize,
                    height: QuotesConstants.Navigation.barButtonSize
                )
            }

            Text(title)
                .font(.headline)
                .lineLimit(QuotesConstants.Navigation.titleLineLimit)
            .frame(maxWidth: .infinity)

            Color.clear.frame(
                width: QuotesConstants.Navigation.barButtonSize,
                height: QuotesConstants.Navigation.barButtonSize
            )
        }
        .padding(.horizontal)
        .padding(.top, QuotesConstants.Navigation.barTopPadding)
        .padding(.bottom, QuotesConstants.Navigation.barBottomPadding)
        .background(.bar)
    }
}
