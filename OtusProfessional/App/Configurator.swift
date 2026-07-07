//
//  Configurator.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation

final class Configurator {
    static let shared = Configurator()

    private let serviceLocator = ServiceLocator.shared

    private init() {}

    func setup() {
        registerServices()
    }

    private func registerServices() {
        serviceLocator.register(QuotesServiceImpl(), for: QuotesService.self)
        serviceLocator.register(MockQuotesService(), for: MockQuotesService.self)
    }
    
    func makeContentView() -> ContentView {
        ContentView(
            quotesService: serviceLocator.require(QuotesService.self)
        )
    }
}
