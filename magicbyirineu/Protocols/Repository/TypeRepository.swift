import Foundation

protocol TypeRepository {
    func fetchTypes(completion: @escaping (Result<[String]>) -> Void)
}
