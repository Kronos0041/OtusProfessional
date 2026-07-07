//
//  AnimechanAPIQuotesService.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation
import AnimechanAPI

final class QuotesServiceImpl: QuotesService {
    private let service: Result<AnimechanService, Error>

    init(service: AnimechanService? = nil) {
        if let service {
            self.service = .success(service)
        } else {
            self.service = Result {
                try AnimechanService()
            }
        }
    }
    
    func getQuotes(query: QuotesQuery, page: Int) async throws -> [AnimechanQuote] {
        let service = try service.get()

        switch query {
        case let .anime(name):
            return try await service.getQuotes(anime: name, page: page)
        case let .character(name):
            return try await service.getQuotes(character: name, page: page)
        }
    }
}
