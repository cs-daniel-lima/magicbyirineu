import Foundation

@testable import magicbyirineu

final class CardsLoaderMock: CardsLoader {
    var isFetchedSuccess = true

    override func fetchCards(with name: String?) {
        var cards = [
            Card(name: "Forest", set: "2ED", setName: "Unlimited Edition", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=890&type=card", types: ["Land"], foreignNames: [ForeignNames(name: "Floresta", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=890&type=card")]),
            Card(name: "Kamahl, Pit Fighter", set: "P15A", setName: "15th Anniversary Cards", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=890&type=card", types: ["Creature"], foreignNames: nil),
            Card(name: "Time Sieve", set: "ARB", setName: "Alara Reborn", imageUrl: nil, types: ["Artifact"], foreignNames: [ForeignNames(name: "Peneira de Tempo", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=189649&type=card")]),
            Card(name: "Vedalken Ghoul", set: "ARB", setName: "Alara Reborn", imageUrl: nil, types: ["Creature"], foreignNames: nil),
            Card(name: "Naga Oracle", set: "AKH", setName: "Amonkhet", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=426764&type=card", types: ["Creature"], foreignNames: nil),
        ]

        if let name = name {
            cards = cards.filter({ (card) -> Bool in
                card.name.lowercased().contains(name.lowercased())
            })
        }

        if isFetchedSuccess {
            delegate?.loaded(
                cards: cards,
                forType: "A",
                andSet: CardSet(code: "SetCode A", name: "Set A", type: "Type A", releaseDate: Date()),
                from: self
            )
        } else {
            delegate?.loaded(error: ErrorMock())
        }
    }
}
