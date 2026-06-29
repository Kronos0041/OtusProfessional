//
//  Configurator.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation

final class Configurator {
    static let shared = Configurator()

    let serviceLocator = ServiceLocator.shared

    private init() {}

    func setup() {
        registerServices()
    }

    private func registerServices() {
        serviceLocator.register(QuotesServiceImpl(), for: QuotesServiceImpl.self)
        serviceLocator.register(MockQuotesService(), for: MockQuotesService.self)
    }
}
