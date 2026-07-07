//
//  ServiceLocator.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()

    private var services: [ObjectIdentifier: Any] = [:]

    func register<Service>(_ service: Service, for type: Service.Type) {
        let key = ObjectIdentifier(type)
        services[key] = service
    }
    
    func require<Service>(_ type: Service.Type) -> Service {
        guard let service = resolve(type) else {
            preconditionFailure("Service \(type) is not registered")
        }
        return service
    }

    func resolve<Service>(_ type: Service.Type) -> Service? {
        let key = ObjectIdentifier(type)
        return services[key] as? Service
    }
}
