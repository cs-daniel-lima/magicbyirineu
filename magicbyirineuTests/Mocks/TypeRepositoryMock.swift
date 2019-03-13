import Foundation

@testable import magicbyirineu
class TypeRepositoryMock: TypeRepository {
    enum TypeRepositoryMockError: Error {
        case couldNotLoad
    }

    var isSuccessful = true

    func fetchTypes(completion: @escaping (Result<[String]>) -> Void) {
        if isSuccessful {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            completion(.success([
                "Artifact",
                "Conspiracy",
                "Creature",
                "Enchantment",
                "Hero",
                "instant",
                "Instant",
                "Land",
                "Phenomenon",
                "Plane",
                "Planeswalker",
                "Scheme",
                "Sorcery",
                "Summon",
                "Tribal",
                "Vanguard",
                "You’ll",
            ]))
        } else {
            completion(.failure(TypeRepositoryMockError.couldNotLoad))
        }
    }
}
