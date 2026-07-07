import SwiftUI

public struct QuotesFloatingAddButton: View {
    private let size: CGFloat
    private let shadowOpacity: Double
    private let shadowRadius: CGFloat
    private let shadowOffsetX: CGFloat
    private let shadowOffsetY: CGFloat
    private let accessibilityLabel: String
    private let action: () -> Void

    /// Создаёт плавающую кнопку добавления с иконкой `plus`.
    ///
    /// Компонент предназначен для закрепления поверх основного контента,
    /// например в нижнем правом углу экрана через `overlay`.
    ///
    /// - Parameters:
    ///   - size: Диаметр круглой кнопки.
    ///   - shadowOpacity: Прозрачность тени под кнопкой.
    ///   - shadowRadius: Радиус размытия тени.
    ///   - shadowOffsetX: Горизонтальное смещение тени.
    ///   - shadowOffsetY: Вертикальное смещение тени.
    ///   - accessibilityLabel: Текст, который VoiceOver озвучивает для кнопки.
    ///   - action: Действие, которое выполняется при нажатии на кнопку.
    public init(
        size: CGFloat = 56,
        shadowOpacity: Double = 0.18,
        shadowRadius: CGFloat = 10,
        shadowOffsetX: CGFloat = 0,
        shadowOffsetY: CGFloat = 4,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) {
        self.size = size
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.shadowOffsetX = shadowOffsetX
        self.shadowOffsetY = shadowOffsetY
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white)
                .frame(width: size, height: size)
                .background(.tint, in: Circle())
                .shadow(
                    color: .black.opacity(shadowOpacity),
                    radius: shadowRadius,
                    x: shadowOffsetX,
                    y: shadowOffsetY
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(accessibilityLabel)
    }
}
