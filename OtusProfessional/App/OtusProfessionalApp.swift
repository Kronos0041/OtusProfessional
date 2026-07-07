//
//  OtusProfessionalApp.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.
//

import SwiftUI

@main
struct OtusProfessionalApp: App {
    
    private let rootView: ContentView
    
    init() {
        Configurator.shared.setup()
        rootView = Configurator.shared.makeContentView()
    }

    var body: some Scene {
        WindowGroup {
            rootView
        }
    }
}
