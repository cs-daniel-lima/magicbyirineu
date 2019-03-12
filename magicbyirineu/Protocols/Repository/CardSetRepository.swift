import Foundation

protocol CardSetRepository {
    func fetchCardSets(completion: @escaping (Result<[CardSet]>) -> Void)
}
