import Foundation

@testable import magicbyirineu

class DatabaseManagerMock: DatabaseManager {
    func eraseAllData() {
        let cardsToDelete = realm.objects(CardDao.self)
        let setsToDelete = realm.objects(CardSetDao.self)
        let typesToDelete = realm.objects(CardTypeDao.self)

        try! realm.write {
            realm.delete(cardsToDelete)
            realm.delete(setsToDelete)
            realm.delete(typesToDelete)
        }
    }

    func getCards(forSets sets: [CardSet]) -> [Card] {
        var cards = [Card]()

        for set in sets {
            cards.append(contentsOf: getCards(setCode: set.code))
        }

        return cards
    }
}
