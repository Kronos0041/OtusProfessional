//
//  ModalSheet.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.
//

import SwiftUI

struct ModalSheetButton: View {
    @State private var isPresented = false
    
    var body: some View {
        Button("Открыть модальное окно") {
            isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            ModalView()
        }
    }
}

struct ModalView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            
            Text("Text 1")
            Text("Text 2")
            Text("Text 3")

            Button("Закрыть") {
                dismiss()
            }
        }
        .padding()
    }
}

#Preview {
    ModalSheetButton()
}
