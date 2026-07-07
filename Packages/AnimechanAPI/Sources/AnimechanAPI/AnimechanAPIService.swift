import Foundation
import OpenAPIURLSession
import HTTPTypes

public final class AnimechanService: @unchecked Sendable {
    private var client: Client

    public init(serverURL: URL? = nil) throws {
        client = Client(
            serverURL: try serverURL ?? Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }

    public func getQuotes(anime: String? = nil, character: String? = nil, page: Int) async throws -> [AnimechanQuote] {
        let response = try await client.getQuotes(
            query: .init(
                anime: anime,
                character: character,
                page: page
            )
        )
        let body: Components.Schemas.QuoteListResponse

        switch response {
        case let .ok(okResponse):
            body = try okResponse.body.json
        case let .undocumented(statusCode, _):
            if statusCode == HTTPResponse.Status.tooManyRequests.code {
                throw AnimechanServiceError.rateLimited
            }
            throw AnimechanServiceError.unexpectedStatusCode(statusCode)
        }

        return body.data.map(AnimechanQuote.init)
    }
}
