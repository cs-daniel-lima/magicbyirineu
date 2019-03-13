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
                Card(id: "3b072bac-4508-5bfa-adc3-13a9163284d3", name: "Forest", set: "2ED", setName: "Unlimited Edition", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=890&type=card", types: ["Land"], foreignNames: [ForeignNames(name: "Floresta", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=890&type=card")]),
                Card(id: "563d3804-b6d3-5711-8f76-8c95a2812699", name: "Kamahl, Pit Fighter", set: "3ED", setName: "Revised Edition", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=890&type=card", types: ["Creature"], foreignNames: nil),
                Card(id: "670bb0df-43fd-5c87-9719-f8e2fc017897", name: "Time Sieve", set: "10E", setName: "Tenth Edition", imageUrl: nil, types: ["Artifact"], foreignNames: [ForeignNames(name: "Peneira de Tempo", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=189649&type=card")]),
                Card(id: "2749ac5b-1668-5e85-83c3-5b61d467eccf", name: "Vedalken Ghoul", set: "5DN", setName: "Fourth Edition", imageUrl: nil, types: ["Creature"], foreignNames: nil),
                Card(id: "64105f87-0173-5bcf-9043-005a066ad016", name: "Naga Oracle", set: "2ED", setName: "Unlimited Edition", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=426764&type=card", types: ["Creature"], foreignNames: nil),
            ]), 5)
        } else {
            completion(.failure(CardRepositoryMockError.couldNotLoad), nil)
        }
    }
}
