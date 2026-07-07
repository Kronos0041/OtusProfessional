//
//  QuotesMiddleware.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation
import AnimechanAPI

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
                return .loadingFailed(localizedLoadingMessage(for: error))
            }
        default:
            return nil
        }
    }
}

private func localizedLoadingMessage(for error: Error) -> String {
    guard let animechanError = error as? AnimechanServiceError else {
        return Strings.Quotes.Error.loadFailed
    }

    switch animechanError {
    case .rateLimited:
        return Strings.Animechan.Error.rateLimited
    case let .unexpectedStatusCode(code):
        return Strings.Animechan.Error.unexpectedStatusCode(code)
    }
}
