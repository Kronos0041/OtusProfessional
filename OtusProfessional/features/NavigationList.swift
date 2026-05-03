//
//  MainTabView 2.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.
//

import SwiftUI

struct NavigationList: View {
    @State private var path: [Color] = [] // Nothing on the stack by default.


    var body: some View {
        NavigationStack(path: $path) {
            List {
                NavigationLink("Purple", value: Color.purple)
                NavigationLink("Pink", value: Color.pink)
                NavigationLink("Orange", value: Color.orange)
            }
            .navigationDestination(for: Color.self) { color in
                ColorDetail(color: color)
            }
        }
    }
}

