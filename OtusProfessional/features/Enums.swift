//
//  Enums.swift
//  OtusProfessional
//
//  Created by Alex on 30.04.2026.
//

import Foundation

enum AppTab: Hashable {
    case home
    case list
    case modal
}

enum ListRoute: Hashable {
    case color(ColorItem)
}

enum ColorItem: String, Hashable {
    case purple
    case pink
    case orange

    var color: Color {
        switch self {
        case .purple: return .purple
        case .pink: return .pink
        case .orange: return .orange
        }
    }

    var title: String {
        rawValue.capitalized
    }
}
