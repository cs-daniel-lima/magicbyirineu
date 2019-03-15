import Foundation

class DatabaseSetsService {
    let databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }
}

extension DatabaseSetsService: CardSetRepository {
    func fetchCardSets(completion: @escaping (Result<[CardSet]>) -> Void) {
        let sets = databaseManager.getSets()

        completion(.success(sets))
    }
}
