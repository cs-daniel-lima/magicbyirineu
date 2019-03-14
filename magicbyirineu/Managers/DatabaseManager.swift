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
        addFavorite(set: set)
        addFavorite(card: card)
        addFavorite(types: card.types)
    }

    private func addFavorite(card: Card) {
        let newCard = CardDao(card: card)

        try! realm.write {
            realm.add(newCard)
        }
    }

    private func addFavorite(set: CardSet) {
        let newSet = CardSetDao(set: set)

        let preExistingSets = realm.objects(CardSetDao.self).filter(NSPredicate(format: "code = %@", newSet.code))

        if preExistingSets.isEmpty {
            try! realm.write {
                realm.add(newSet)
            }
        }
    }

    private func addFavorite(types: [String]) {
        for type in types {
            let newType = CardTypeDao(type: type)

            let preExistingTypes = realm.objects(CardTypeDao.self).filter(NSPredicate(format: "name = %@", newType.name))

            if preExistingTypes.isEmpty {
                try! realm.write {
                    realm.add(newType)
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
            try! realm.write {
                realm.delete(favoritedCard)
            }

            removeFavorite(set: set)
            removeFavorite(types: card.types)
        }
    }

    private func removeFavorite(set: CardSet) {
        let cardsWithSet = getCards(setCode: set.code)

        if cardsWithSet.isEmpty {
            let result = realm.objects(CardSetDao.self).filter(NSPredicate(format: "code = %@", set.code))

            try! realm.write {
                realm.delete(result)
            }
        }
    }

    private func removeFavorite(types: [String]) {
        for type in types {
            let cardsWithType = getCards(type: type)

            if cardsWithType.isEmpty {
                let result = realm.objects(CardTypeDao.self).filter(NSPredicate(format: "name = %@", type))

                try! realm.write {
                    realm.delete(result)
                }
            }
        }
    }
}
