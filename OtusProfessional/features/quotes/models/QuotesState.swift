//
//  QuotesState.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//
//  Неизменяемый снимок состояния экрана. Только данные + производные значения,
//  без бизнес-логики (вся мутация — в QuotesReducer).
//

import Foundation
import AnimechanAPI

enum QuotesViewMode: Equatable {
    case content
    case loading
    case errorMessage(String)
}

struct QuotesState {
    /// Контекст фиксируется при создании экрана и не меняется.
    let context: QuotesContext
    let excludedQuoteID: UUID?

    var rubric: QuotesRubric = .anime
    var animeQueryName: String?
    var characterQueryName: String?
    var quotes: [AnimechanQuote] = []
    var page = QuotesConstants.Pagination.firstPage
    var canLoadNextPage = true
    var viewMode: QuotesViewMode = .content
    var isQueryDialogPresented = false
    var queryDraft = ""

    init(context: QuotesContext, excludedQuoteID: UUID? = nil) {
        self.context = context
        self.excludedQuoteID = excludedQuoteID

        if case let .related(anime, character) = context {
            animeQueryName = anime
            characterQueryName = character
        }
    }

    var errorMessage: String? {
        guard case let .errorMessage(text) = viewMode else { return nil }
        return text
    }

    var isLoadingPage: Bool { viewMode == .loading && !quotes.isEmpty }

    var visibleQuotes: [AnimechanQuote] {
        guard let excludedQuoteID else { return quotes }
        return quotes.filter { $0.id != excludedQuoteID }
    }

    var title: String {
        switch context {
        case .default:
            return Strings.Quotes.title
        case let .related(anime, _):
            return anime
        }
    }

    /// Активный запрос = выбранная рубрика + пользовательское значение.
    var activeQuery: QuotesQuery? {
        switch rubric {
        case .anime:
            return animeQueryName.map(QuotesQuery.anime)
        case .character:
            return characterQueryName.map(QuotesQuery.character)
        }
    }

    var subtitle: String {
        activeQuery?.subtitle ?? Strings.Quotes.Subtitle.empty
    }

    var dialogTitle: String {
        switch rubric {
        case .anime: return Strings.Quotes.Dialog.Title.anime
        case .character: return Strings.Quotes.Dialog.Title.character
        }
    }

    var dialogPlaceholder: String {
        switch rubric {
        case .anime: return Strings.Quotes.Dialog.Placeholder.anime
        case .character: return Strings.Quotes.Dialog.Placeholder.character
        }
    }

    var currentQueryName: String {
        switch rubric {
        case .anime: return animeQueryName ?? ""
        case .character: return characterQueryName ?? ""
        }
    }
}
