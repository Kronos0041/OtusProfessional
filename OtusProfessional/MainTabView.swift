//
//  MainTabView.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.
//

import SwiftUI

struct MainTabView: View {
    
    @State var selection: AppTab = .home
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Главная", systemImage: "house", value: .home) {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    
                    Button("Открыть purple") {
                        selection = .list
                    }
                }
            }
            
            Tab("Список", systemImage: "list.bullet", value: .list) {
                NavigationList()
            }
            
            Tab("Модалка", systemImage: "ellipsis.circle", value: .modal) {
                ModalSheetButton()
            }
        }
    }
}
