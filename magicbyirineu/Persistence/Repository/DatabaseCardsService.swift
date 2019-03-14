import Foundation

class DatabaseCardsService {
    let databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager = DatabaseManager()) {
        self.databaseManager = databaseManager
    }
}

extension DatabaseCardsService: CardRepository {
    func fetchCards(page _: Int?, name: String?, setCode: String?, type _: String?, orderParameter _: CardOrder?, completion: @escaping (Result<[Card]>, Int?) -> Void) {
        if let nameToSearch = name, let setToSearch = setCode {
            let cards = databaseManager.getCards(name: nameToSearch, setCode: setToSearch)
            completion(.success(cards), nil)

        } else {
            if let nameToSearch = name {
                let cards = databaseManager.getCards(name: nameToSearch)
                completion(.success(cards), nil)
            }

            if let setToSearch = setCode {
                let cards = databaseManager.getCards(setCode: setToSearch)
                completion(.success(cards), nil)
            }
        }
    }
}
