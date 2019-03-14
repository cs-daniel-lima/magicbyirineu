import Realm
import RealmSwift

class DatabaseManager {
    let realm: Realm

    init() {
        let config = Utils.createConfigurationFile()
        realm = try! Realm(configuration: config)
    }

    // MARK: - Insert Data

    func addFavorite(card: Card, set: CardSet) {
        do {
            try addFavorite(set: set)
            try addFavorite(card: card)
            try addFavorite(types: card.types)
        } catch let error as NSError {
            Logger.log(in: self, message: error.description)
        }
    }

    private func addFavorite(card: Card) throws {
        let newCard = CardDao(card: card)

        do {
            try realm.write {
                realm.add(newCard)
            }
        } catch let error as NSError {
            throw error
        }
    }

    private func addFavorite(set: CardSet) throws {
        let newSet = CardSetDao(set: set)

        let preExistingSets = realm.objects(CardSetDao.self).filter(NSPredicate(format: "code = %@", newSet.code))

        if preExistingSets.isEmpty {
            do {
                try realm.write {
                    realm.add(newSet)
                }
            } catch let error as NSError {
                throw error
            }
        }
    }

    private func addFavorite(types: [String]) throws {
        for type in types {
            let newType = CardTypeDao(type: type)

            let preExistingTypes = realm.objects(CardTypeDao.self).filter(NSPredicate(format: "name = %@", newType.name))

            if preExistingTypes.isEmpty {
                do {
                    try realm.write {
                        realm.add(newType)
                    }
                } catch let error as NSError {
                    throw error
                }
            }
        }
    }

    // MARK: - Select Data

    func isfavorited(card: Card) -> Bool {
        if realm.object(ofType: CardDao.self, forPrimaryKey: card.id) != nil {
            return true
        } else {
            return false
        }
    }

    func getSets() -> [CardSet] {
        let result = realm.objects(CardSetDao.self)
        return result.toArray()
    }

    func getTypes() -> [String] {
        let result = realm.objects(CardTypeDao.self)
        return result.toArrayOfString()
    }

    func getCards(name: String, setCode: String) -> [Card] {
        let result = realm.objects(CardDao.self).filter(NSPredicate(format: "name = %@ AND set = %@", name, setCode))
        return result.toArray()
    }

    func getCards(name: String) -> [Card] {
        let result = realm.objects(CardDao.self).filter(NSPredicate(format: "name CONTAINS[cd] %@", name))

        return result.toArray()
    }

    func getCards(setCode: String) -> [Card] {
        let result = realm.objects(CardDao.self).filter(NSPredicate(format: "set = %@", setCode))
        return result.toArray()
    }

    func getCards(type: String) -> [Card] {
        let result = realm.objects(CardDao.self).filter(NSPredicate(format: "%@ IN foreignNames.name", type))
        return result.toArray()
    }

    // MARK: - Delete Data

    func removeFavorite(card: Card, set: CardSet) {
        if let favoritedCard = realm.object(ofType: CardDao.self, forPrimaryKey: card.id) {
            do {
                try realm.write {
                    realm.delete(favoritedCard)
                }
            } catch let error as NSError {
                Logger.logError(in: self, message: error.description)
            }

            removeFavorite(set: set)
            removeFavorite(types: card.types)
        }
    }

    private func removeFavorite(set: CardSet) {
        let cardsWithSet = getCards(setCode: set.code)

        if cardsWithSet.isEmpty {
            let result = realm.objects(CardSetDao.self).filter(NSPredicate(format: "code = %@", set.code))

            do {
                try realm.write {
                    realm.delete(result)
                }
            } catch let error as NSError {
                Logger.logError(in: self, message: error.description)
            }
        }
    }

    private func removeFavorite(types: [String]) {
        for type in types {
            let cardsWithType = getCards(type: type)

            if cardsWithType.isEmpty {
                let result = realm.objects(CardTypeDao.self).filter(NSPredicate(format: "name = %@", type))

                do {
                    try realm.write {
                        realm.delete(result)
                    }
                } catch let error as NSError {
                    Logger.logError(in: self, message: error.description)
                }
            }
        }
    }
}
