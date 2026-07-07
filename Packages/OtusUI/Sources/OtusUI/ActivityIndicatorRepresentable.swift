import SwiftUI
import UIKit

public struct ActivityIndicatorRepresentable: UIViewRepresentable {
    @Binding private var isAnimating: Bool
    private let style: UIActivityIndicatorView.Style

    /// Создаёт обёртку над `UIActivityIndicatorView` для использования в SwiftUI.
    ///
    /// Компонент синхронизирует состояние UIKit-индикатора с переданным `Binding`:
    /// запускает анимацию при `true` и останавливает её при `false`.
    ///
    /// - Parameters:
    ///   - isAnimating: Связь со SwiftUI-состоянием, которое управляет запуском и остановкой индикатора.
    ///   - style: Визуальный стиль системного индикатора активности.
    public init(
        isAnimating: Binding<Bool>,
        style: UIActivityIndicatorView.Style = .large
    ) {
        _isAnimating = isAnimating
        self.style = style
    }

    public func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.hidesWhenStopped = true
        return indicator
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
