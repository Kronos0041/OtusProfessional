//
//  MainTabView.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.
//

import SwiftUI

struct MainTabView: View {
    
    @State var selection: AppTab = .home
    @State private var loading = true
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Главная", systemImage: "house", value: .home) {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    
                    Button("Открыть 2 табу") {
                        selection = .list
                    }
                    
                    
                    Button("Переключить UIViewRepresentable") {
                        loading = !loading
                    }
                    
                    ActivityIndicatorRepresentable(isAnimating: $loading)
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
