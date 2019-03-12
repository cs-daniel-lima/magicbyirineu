import Foundation

class CardSetAPIClient {
    let apiManager: APIManager

    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
}

extension CardSetAPIClient: CardSetRepository {
    func fetchCardSets(completion: @escaping (Result<[CardSet]>) -> Void) {
        let endpoint = EndpointSets()

        apiManager.fetch(endpoint) { result, _ in
            switch result {
            case let .success(response):
                completion(.success(response.sets))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
