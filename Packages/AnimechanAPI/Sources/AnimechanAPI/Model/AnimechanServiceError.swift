import Foundation

public enum AnimechanServiceError: LocalizedError, Sendable {
    case rateLimited
    case unexpectedStatusCode(Int)

    public var errorDescription: String? {
        switch self {
        case .rateLimited:
            return "Слишком много запросов к Animechan. Подождите немного и попробуйте обновить список."
        case let .unexpectedStatusCode(code):
            return "Animechan вернул неожиданный код ответа: \(code)."
        }
    }
}
