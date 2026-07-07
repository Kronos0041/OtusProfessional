import Foundation

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
    
    init(_ quote: Components.Schemas.Quote) {
        self.init(
            content: quote.content,
            anime: AnimechanNamedResource(id: quote.anime.id, name: quote.anime.name),
            character: AnimechanNamedResource(id: quote.character.id, name: quote.character.name)
        )
    }
}
