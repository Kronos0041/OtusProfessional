//
//  MockQuotesService.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation
import AnimechanAPI

enum MockQuotesServiceError: LocalizedError {
    case missingFile

    var errorDescription: String? {
        switch self {
        case .missingFile:
            return "Не найден файл MockAnimechanQuotes.json."
        }
    }
}

final class MockQuotesService: QuotesService {
    private let pageSize: Int
    private let bundle: Bundle

    init(pageSize: Int = QuotesConstants.Pagination.mockPageSize, bundle: Bundle = .main) {
        self.pageSize = pageSize
        self.bundle = bundle
    }

    func getQuotes(query: QuotesQuery, page: Int) async throws -> [AnimechanQuote] {
        let quotes = try loadQuotes()
        let filteredQuotes = quotes.filter { quote in
            switch query {
            case let .anime(name):
                return quote.anime.name.localizedCaseInsensitiveContains(name)
            case let .character(name):
                return quote.character.name.localizedCaseInsensitiveContains(name)
            }
        }
        let resultQuotes = filteredQuotes.isEmpty ? quotes : filteredQuotes

        let startIndex = max(
            QuotesConstants.Pagination.minimumStartIndex,
            (page - QuotesConstants.Pagination.firstPage) * pageSize
        )
        guard startIndex < resultQuotes.count else { return [] }

        let endIndex = min(startIndex + pageSize, resultQuotes.count)
        return Array(resultQuotes[startIndex..<endIndex]).map(AnimechanQuote.init)
    }

    private func loadQuotes() throws -> [MockAnimechanQuote] {
        guard let url = bundle.url(forResource: "MockAnimechanQuotes", withExtension: "json") else {
            throw MockQuotesServiceError.missingFile
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([MockAnimechanQuote].self, from: data)
    }
}

private struct MockAnimechanQuote: Decodable {
    let content: String
    let anime: MockAnimechanNamedResource
    let character: MockAnimechanNamedResource
}

private struct MockAnimechanNamedResource: Decodable {
    let id: Int
    let name: String
}

private extension AnimechanQuote {
    init(_ quote: MockAnimechanQuote) {
        self.init(
            content: quote.content,
            anime: AnimechanNamedResource(id: quote.anime.id, name: quote.anime.name),
            character: AnimechanNamedResource(id: quote.character.id, name: quote.character.name)
        )
    }
}
