//
//  AnimechanAPIQuotesService.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation
import AnimechanAPI

final class QuotesServiceImpl: QuotesService {
    private let service = AnimechanService()
    
    func fetchQuotes(query: AnimechanQuery, page: Int) async throws -> [AnimechanQuote] {
        try await service.fetchQuotes(query: query, page: page)
    }
}
