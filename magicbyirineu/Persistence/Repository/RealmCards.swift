import Foundation

class RealmCards {
    let databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager = DatabaseManager()) {
        self.databaseManager = databaseManager
    }
}

extension RealmCards: CardRepository {
    func fetchCards(page: Int?, name: String?, setCode: String?, type: String?, orderParameter: CardOrder?, completion: @escaping (Result<[Card]>, HTTPHeaderCards?) -> Void) {
        
        if let nameToSearch = name, let setToSearch = setCode {
            let cards = databaseManager.getCards(name: nameToSearch, setCode: setToSearch)
            completion(.success(cards), HTTPHeaderCards(count:cards.count, totalCount: cards.count))

        } else {
            if let nameToSearch = name {
                let cards = databaseManager.getCards(name: nameToSearch)
                completion(.success(cards), HTTPHeaderCards(count:cards.count, totalCount: cards.count))
            }

            if let setToSearch = setCode {
                let cards = databaseManager.getCards(setCode: setToSearch)
                completion(.success(cards), HTTPHeaderCards(count:cards.count, totalCount: cards.count))
            }
        }
    }
}
