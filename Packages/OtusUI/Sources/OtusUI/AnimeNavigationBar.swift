import SwiftUI

public struct AnimeNavigationBar: View {
    private let title: String
    private let canGoBack: Bool
    private let barButtonSize: CGFloat
    private let titleLineLimit: Int
    private let topPadding: CGFloat
    private let bottomPadding: CGFloat
    private let onBack: () -> Void

    /// Создаёт компактную навигационную панель с заголовком и опциональной кнопкой назад.
    ///
    /// Если `canGoBack` равен `false`, место под левую кнопку сохраняется пустым,
    /// чтобы заголовок оставался визуально выровненным по центру.
    ///
    /// - Parameters:
    ///   - title: Текст заголовка, отображаемый в центре панели.
    ///   - canGoBack: Флаг, который управляет отображением кнопки возврата.
    ///   - barButtonSize: Ширина и высота области под кнопку возврата.
    ///   - titleLineLimit: Максимальное количество строк для заголовка.
    ///   - topPadding: Верхний внутренний отступ панели.
    ///   - bottomPadding: Нижний внутренний отступ панели.
    ///   - onBack: Действие, которое выполняется при нажатии на кнопку возврата.
    public init(
        title: String,
        canGoBack: Bool,
        barButtonSize: CGFloat = 36,
        titleLineLimit: Int = 1,
        topPadding: CGFloat = 10,
        bottomPadding: CGFloat = 8,
        onBack: @escaping () -> Void
    ) {
        self.title = title
        self.canGoBack = canGoBack
        self.barButtonSize = barButtonSize
        self.titleLineLimit = titleLineLimit
        self.topPadding = topPadding
        self.bottomPadding = bottomPadding
        self.onBack = onBack
    }

    public var body: some View {
        HStack {
            if canGoBack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .frame(width: barButtonSize, height: barButtonSize)
                }
            } else {
                Color.clear.frame(width: barButtonSize, height: barButtonSize)
            }

            Text(title)
                .font(.headline)
                .lineLimit(titleLineLimit)
                .frame(maxWidth: .infinity)

            Color.clear.frame(width: barButtonSize, height: barButtonSize)
        }
        .padding(.horizontal)
        .padding(.top, topPadding)
        .padding(.bottom, bottomPadding)
        .background(.bar)
    }
}
