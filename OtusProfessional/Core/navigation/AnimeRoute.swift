//
//  AnimeRoute.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
import Foundation
import AnimechanAPI

struct AnimeRoute: Hashable, Identifiable {
    let id: UUID
    let quote: AnimechanQuote
    let depth: Int

    init(
        id: UUID = UUID(),
        quote: AnimechanQuote,
        depth: Int
    ) {
        self.id = id
        self.quote = quote
        self.depth = depth
    }
}
