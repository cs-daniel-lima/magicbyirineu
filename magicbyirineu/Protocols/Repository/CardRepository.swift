import Foundation

protocol CardRepository {
    func fetchCards(page: Int?, name: String?, setCode: String?, type: String?, orderParameter: CardOrder?, completion: @escaping (Result<[Card]>, HTTPHeaderCards?) -> Void)
}
