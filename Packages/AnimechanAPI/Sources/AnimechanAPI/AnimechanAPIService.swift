import Foundation
import OpenAPIURLSession

public enum AnimechanQuery: Hashable, Sendable {
    case anime(String)
    case character(String)
}

public struct AnimechanNamedResource: Hashable, Identifiable, Sendable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public struct AnimechanQuote: Hashable, Identifiable, Sendable {
    public let id: UUID
    public let content: String
    public let anime: AnimechanNamedResource
    public let character: AnimechanNamedResource

    public init(
        id: UUID = .init(),
        content: String,
        anime: AnimechanNamedResource,
        character: AnimechanNamedResource
    ) {
        self.id = id
        self.content = content
        self.anime = anime
        self.character = character
    }
}

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

public final class AnimechanService: @unchecked Sendable {
    private let client: Client

    public init() {
        client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }

    public func fetchQuotes(query: AnimechanQuery, page: Int) async throws -> [AnimechanQuote] {
        let response = try await client.getQuotes(
            query: .init(
                anime: query.animeName,
                character: query.characterName,
                page: page
            )
        )
        let body: Components.Schemas.QuoteListResponse

        switch response {
        case let .ok(okResponse):
            body = try okResponse.body.json
        case let .undocumented(statusCode, _):
            if statusCode == 429 {
                throw AnimechanServiceError.rateLimited
            }

            throw AnimechanServiceError.unexpectedStatusCode(statusCode)
        }

        return body.data.map(AnimechanQuote.init)
    }
}

private extension AnimechanQuery {
    var animeName: String? {
        switch self {
        case let .anime(name): return name
        case .character: return nil
        }
    }

    var characterName: String? {
        switch self {
        case .anime: return nil
        case let .character(name): return name
        }
    }
}

private extension AnimechanQuote {
    init(_ quote: Components.Schemas.Quote) {
        self.init(
            content: quote.content,
            anime: AnimechanNamedResource(quote.anime),
            character: AnimechanNamedResource(quote.character)
        )
    }
}

private extension AnimechanNamedResource {
    init(_ resource: Components.Schemas.NamedResource) {
        self.init(id: resource.id, name: resource.name)
    }
}
