import Foundation

@testable import magicbyirineu

class DatabaseManagerMock: DatabaseManager {
    func eraseAllData() {
        let cardsToDelete = realm.objects(CardDao.self)
        let setsToDelete = realm.objects(CardSetDao.self)
        let typesToDelete = realm.objects(CardTypeDao.self)

        do {
            try realm.write {
                realm.delete(cardsToDelete)
                realm.delete(setsToDelete)
                realm.delete(typesToDelete)
            }
        } catch let error as NSError {
            Logger.logError(in: self, message: error.description)
        }
    }

    func getAllCards() -> [Card] {
        let result = realm.objects(CardDao.self)
        return result.toArray()
    }

    func getCards(forSets sets: [CardSet]) -> [Card] {
        var cards = [Card]()

        for set in sets {
            cards.append(contentsOf: getCards(setCode: set.code))
        }

        return cards
    }
}
