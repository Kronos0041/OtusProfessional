//
//  QuotesMiddleware.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation

func quotesMiddleware(service: QuotesService) -> Middleware<QuotesState, QuotesAction> {
    { state, action in
        switch action {
        case .screenAppeared, .quoteAppeared, .loadNextPage, .reload, .selectRubric, .confirmQueryDialog:
            guard state.viewMode == .loading, let query = state.activeQuery else { return nil }

            do {
                let quotes = try await service.fetchQuotes(
                    query: query.apiQuery,
                    page: state.page
                )
                return .quotesLoaded(quotes)
            } catch {
                return .loadingFailed(error.localizedDescription)
            }
        default:
            return nil
        }
    }
}
