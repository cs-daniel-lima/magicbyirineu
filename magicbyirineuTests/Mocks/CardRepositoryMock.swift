import Foundation

@testable import magicbyirineu
class CardRepositoryMock: CardRepository {
    enum CardRepositoryMockError: Error {
        case couldNotLoad
    }

    var isSuccessfull = true

    func fetchCards(page _: Int?, name _: String?, setCode _: String?, type _: String?, orderParameter _: CardOrder?, completion: @escaping (Result<[Card]>, Int?) -> Void) {
        if isSuccessfull {
            completion(.success([
                Card(name: "Forest", set: "2ED", setName: "Unlimited Edition", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=890&type=card", types: ["Land"], foreignNames: [ForeignNames(name: "Floresta", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=890&type=card")]),
                Card(name: "Kamahl, Pit Fighter", set: "P15A", setName: "15th Anniversary Cards", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=890&type=card", types: ["Creature"], foreignNames: nil),
                Card(name: "Time Sieve", set: "ARB", setName: "Alara Reborn", imageUrl: nil, types: ["Artifact"], foreignNames: [ForeignNames(name: "Peneira de Tempo", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=189649&type=card")]),
                Card(name: "Vedalken Ghoul", set: "ARB", setName: "Alara Reborn", imageUrl: nil, types: ["Creature"], foreignNames: nil),
                Card(name: "Naga Oracle", set: "AKH", setName: "Amonkhet", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=426764&type=card", types: ["Creature"], foreignNames: nil),
            ]), 5)
        } else {
            completion(.failure(CardRepositoryMockError.couldNotLoad), nil)
        }
    }
}
