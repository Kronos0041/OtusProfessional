//
//  QuotesReducer.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.

import Foundation
import AnimechanAPI

func quotesReducer(state: inout QuotesState, action: QuotesAction) {
    switch action {
    case .screenAppeared:              loadInitialPageIfNeeded(&state)
    case .quoteAppeared(let id):       loadNextPageIfNeeded(afterAppearing: id, &state)
    case .loadNextPage:                 startLoading(&state)
    case .reload:                       resetForReload(&state)
    case .selectRubric(let r):          selectRubric(r, &state)
    case .showQueryDialog:              showQueryDialog(&state)
    case .updateQueryDraft(let text):   updateQueryDraft(text, &state)
    case .cancelQueryDialog:            cancelQueryDialog(&state)
    case .confirmQueryDialog:           confirmQueryDialog(&state)
    case .quotesLoaded(let b):          appendPage(b, &state)
    case .loadingFailed(let m):         fail(m, &state)
    }
}

private func startLoading(_ state: inout QuotesState) {
    guard state.activeQuery != nil else { return }

    state.viewMode = .loading
}

private func loadInitialPageIfNeeded(_ state: inout QuotesState) {
    guard state.activeQuery != nil else { return }
    guard state.quotes.isEmpty else { return }
    guard state.errorMessage == nil else { return }

    startLoading(&state)
}

private func loadNextPageIfNeeded(afterAppearing quoteID: UUID, _ state: inout QuotesState) {
    guard quoteID == state.visibleQuotes.last?.id else { return }
    guard state.canLoadNextPage else { return }
    guard state.viewMode != .loading else { return }

    startLoading(&state)
}

private func resetForReload(_ state: inout QuotesState) {
    state.quotes = []
    state.page = QuotesConstants.Pagination.firstPage
    state.canLoadNextPage = true
    state.viewMode = state.activeQuery == nil ? .content : .loading
}

private func selectRubric(_ rubric: QuotesRubric, _ state: inout QuotesState) {
    guard rubric != state.rubric else { return }
    state.rubric = rubric
    resetForReload(&state)
}

private func showQueryDialog(_ state: inout QuotesState) {
    state.queryDraft = state.currentQueryName
    state.isQueryDialogPresented = true
}

private func updateQueryDraft(_ text: String, _ state: inout QuotesState) {
    state.queryDraft = text
}

private func cancelQueryDialog(_ state: inout QuotesState) {
    state.isQueryDialogPresented = false
    state.queryDraft = ""
}

private func confirmQueryDialog(_ state: inout QuotesState) {
    let queryName = state.queryDraft.trimmingCharacters(in: .whitespacesAndNewlines)

    guard !queryName.isEmpty else {
        state.viewMode = .errorMessage(Strings.Quotes.Error.emptyQuery)
        return
    }

    switch state.rubric {
    case .anime:
        state.animeQueryName = queryName
    case .character:
        state.characterQueryName = queryName
    }

    state.isQueryDialogPresented = false
    state.queryDraft = ""
    resetForReload(&state)
}

private func appendPage(_ batch: [AnimechanQuote], _ state: inout QuotesState) {
    state.quotes += batch
    state.page += QuotesConstants.Pagination.pageStep
    state.canLoadNextPage = !batch.isEmpty
    state.viewMode = .content
}

private func fail(_ message: String, _ state: inout QuotesState) {
    state.canLoadNextPage = false
    state.viewMode = .errorMessage(message)
}
