import Foundation

class DatabaseTypesService {
    let databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }
}

extension DatabaseTypesService: TypeRepository {
    func fetchTypes(completion: @escaping (Result<[String]>) -> Void) {
        let types = databaseManager.getTypes()

        completion(.success(types))
    }
}
