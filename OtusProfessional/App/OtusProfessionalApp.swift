//
//  OtusProfessionalApp.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.
//

import SwiftUI

@main
struct OtusProfessionalApp: App {
    init() {
        Configurator.shared.setup()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
