//
//  Constants.swift
//  OtusProfessional
//
//  Created by Alex on 29.06.2026.
//

import Foundation
import CoreGraphics

enum QuotesConstants {
    enum Layout {
        static let zeroSpacing: CGFloat = 0
        static let segmentedBottomPadding: CGFloat = 8
        static let floatingButtonTrailingPadding: CGFloat = 24
        static let floatingButtonBottomPadding: CGFloat = 24
        static let quoteSectionVerticalPadding: CGFloat = 8
    }

    enum FlightAnimation {
        static let duration: TimeInterval = 0.62
        static let finalOffsetX: CGFloat = 92
        static let listInitialOffsetY: CGFloat = 160
        static let detailInitialOffsetY: CGFloat = 220
        static let finalOffsetY: CGFloat = 620
        static let initialScale: CGFloat = 0.92
        static let finalScale: CGFloat = 0.2
        static let initialRotationDegrees: Double = 0
        static let finalRotationDegrees: Double = 22
        static let initialOpacity: Double = 0.95
        static let finalOpacity: Double = 0
    }

    enum Navigation {
        static let rootDepth = 1
        static let depthStep = 1
        static let maximumPathCount = 2
        static let transitionDuration: TimeInterval = 0.28
        static let barButtonSize: CGFloat = 36
        static let barTopPadding: CGFloat = 10
        static let barBottomPadding: CGFloat = 8
        static let titleLineLimit = 1
    }

    enum FloatingButton {
        static let size: CGFloat = 56
        static let shadowOpacity: Double = 0.18
        static let shadowRadius: CGFloat = 10
        static let shadowOffsetX: CGFloat = 0
        static let shadowOffsetY: CGFloat = 4
    }

    enum QuoteRow {
        static let verticalSpacing: CGFloat = 10
        static let metadataSpacing: CGFloat = 10
        static let metadataSpacerMinLength: CGFloat = 8
        static let contentLineLimit = 4
        static let metadataLineLimit = 1
        static let verticalPadding: CGFloat = 8
    }

    enum Pagination {
        static let firstPage = 1
        static let pageStep = 1
        static let minimumStartIndex = 0
        static let mockPageSize = 10
    }
}
