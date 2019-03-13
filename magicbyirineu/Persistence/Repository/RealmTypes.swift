import Foundation

class RealmTypes {
    let databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager = DatabaseManager()) {
        self.databaseManager = databaseManager
    }
}

extension RealmTypes: TypeRepository {
    func fetchTypes(completion: @escaping (Result<[String]>) -> Void) {
        let types = databaseManager.getTypes()

        completion(.success(types))
    }
}
