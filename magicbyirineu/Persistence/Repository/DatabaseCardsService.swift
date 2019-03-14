import Foundation

class DatabaseCardsService {
    let databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager = DatabaseManager()) {
        self.databaseManager = databaseManager
    }
}

<<<<<<< HEAD:magicbyirineu/Persistence/Repository/DatabaseCardsService.swift
extension DatabaseCardsService: CardRepository {
    func fetchCards(page _: Int?, name: String?, setCode: String?, type _: String?, orderParameter _: CardOrder?, completion: @escaping (Result<[Card]>, Int?) -> Void) {
=======
extension RealmCards: CardRepository {
    func fetchCards(page: Int?, name: String?, setCode: String?, type: String?, orderParameter: CardOrder?, completion: @escaping (Result<[Card]>, HTTPHeaderCards?) -> Void) {
        
>>>>>>> develop:magicbyirineu/Persistence/Repository/RealmCards.swift
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
