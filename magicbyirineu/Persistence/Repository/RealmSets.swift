import Foundation

class RealmSets {
    let databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager = DatabaseManager()) {
        self.databaseManager = databaseManager
    }
}

extension RealmSets: CardSetRepository {
    func fetchCardSets(completion: @escaping (Result<[CardSet]>) -> Void) {
        let sets = databaseManager.getSets()

        completion(.success(sets))
    }
}
