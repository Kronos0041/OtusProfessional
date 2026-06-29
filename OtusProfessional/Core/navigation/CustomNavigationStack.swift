//
//  CustomNavigationStack.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation
import SwiftUI

struct CustomNavigationStack<Root: View, Destination: View>: View {
    @Binding var path: [AnimeRoute]
    let root: Root
    let destination: (AnimeRoute) -> Destination

    init(
        path: Binding<[AnimeRoute]>,
        @ViewBuilder root: () -> Root,
        @ViewBuilder destination: @escaping (AnimeRoute) -> Destination
    ) {
        _path = path
        self.root = root()
        self.destination = destination
    }

    var body: some View {
        ZStack {
            root
                // Тапы поверх предыдущей view не учитываеются
                .allowsHitTesting(path.isEmpty)
                .zIndex(.zero)

            ForEach(Array(path.enumerated()), id: \.offset) { index, route in
                destination(route)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .trailing)
                    ))
                    .allowsHitTesting(index == path.count - QuotesConstants.Navigation.depthStep)
                    .zIndex(Double(index + QuotesConstants.Navigation.depthStep))
            }
        }
        .animation(.snappy(duration: QuotesConstants.Navigation.transitionDuration), value: path)
    }
}
