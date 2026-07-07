//
//  QuotesModels.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.

import Foundation

/// Рубрика выбора цитат внутри одного экрана.
enum QuotesRubric: String, CaseIterable, Identifiable {
    case anime
    case character

    var id: String { rawValue }

    var title: String {
        switch self {
        case .anime:     return SwiftGen.Quotes.Rubric.anime
        case .character: return SwiftGen.Quotes.Rubric.character
        }
    }
}

/// Контекст экрана: корневой список или связанные цитаты (переход вглубь).
enum QuotesContext: Hashable {
    case `default`
    case related(anime: String, character: String)
}

enum QuotesQuery: Hashable {
    case anime(String)
    case character(String)

    var subtitle: String {
        switch self {
        case let .anime(name):     return SwiftGen.Quotes.Query.anime(name)
        case let .character(name): return SwiftGen.Quotes.Query.character(name)
        }
    }
}
