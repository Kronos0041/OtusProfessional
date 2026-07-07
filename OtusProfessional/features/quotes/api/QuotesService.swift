//
//  QuotesService.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation
import AnimechanAPI

protocol QuotesService {
    func getQuotes(query: QuotesQuery, page: Int) async throws -> [AnimechanQuote]
}
