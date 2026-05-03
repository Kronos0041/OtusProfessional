//
//  ColorDetail.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.
//


import SwiftUI

struct ColorDetail: View {
    let color: Color

    var body: some View {
        ZStack {
            color
                .ignoresSafeArea()
        }
        .navigationTitle("Цвет: \(colorName)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var colorName: String {
       switch color {
       case .purple: return "Purple"
       case .pink: return "Pink"
       case .orange: return "Orange"
       default: return "Some color"
       }
   }
}
