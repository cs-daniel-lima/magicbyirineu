import Foundation

class CardAPIClient {
    let apiManager: APIManager

    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
}

extension CardAPIClient: CardRepository {
    func fetchCards(page: Int?, name: String?, setCode: String?, type: String?, orderParameter: CardOrder?, completion: @escaping (Result<[Card]>, Int?) -> Void) {
        let endpoint = EndpointCards(page: page, name: name, setCode: setCode, type: type, orderParameter: orderParameter)

        apiManager.fetch(endpoint) { result, totalCount in
            switch result {
            case let .success(response):
                completion(.success(response.cards), totalCount)
            case let .failure(error):
                completion(.failure(error), nil)
            }
        }
    }
}
