import Foundation

class CardsLoaderError: Error {
    class RequestTimeOut: Error {
        var localizedDescription: String {
            return "Not possible to access the data"
        }
    }
}

protocol CardsLoaderDelegate {
    func loaded(cards: [Card], forType type: String, andSet set: CardSet, from loader: CardsLoader)
    func loaded(error: Error)
}

/// Carrega cartas de um Set
class CardsLoader {
    // MARK: - Properties

    // MARK: Private

    private let cardRepository: CardRepository
    private let cardSetRepository: CardSetRepository
    private let typeRepository: TypeRepository

    private var currentType: String?
    private var currentSet: CardSet?
    private var typesIterator: IndexingIterator<[String]>?
    private var setsIterator: IndexingIterator<[CardSet]>?
    private var currentPage = 1
    private var requestedCardsCounter = 0
    private var requestTimeOut = 2

    // MARK: Public

    private(set) var cards: [Card] = Array()
    private(set) var types: [String] = [String]()
    private(set) var sets: [CardSet] = [CardSet]()

    var isSetsAndTypesLoaded: Bool {
        return !types.isEmpty && !sets.isEmpty
    }

    var delegate: CardsLoaderDelegate?

    // MARK: - Init

    init(cardRepository: CardRepository, cardSetRepository: CardSetRepository, typeRepository: TypeRepository) {
        self.cardRepository = cardRepository
        self.cardSetRepository = cardSetRepository
        self.typeRepository = typeRepository
    }

    // MARK: - Functions

    func clean() {
        sets = [CardSet]()
        types = [String]()
        cleanButKeepSetsAndTypes()
    }

    func cleanButKeepSetsAndTypes() {
        currentSet = nil
        currentType = nil
        currentPage = 0
        requestedCardsCounter = 0
        cards = Array()
        setsIterator = setsIterator?.makeIterator()
        typesIterator = typesIterator?.makeIterator()
    }

    func fetchSets(completion: ((_ success: Bool) -> Void)? = nil) {
        cardSetRepository.fetchCardSets { result in
            switch result {
            case let .success(sets):
                self.sets = sets
                self.sets.sort(by: { (before, after) -> Bool in
                    before.releaseDate > after.releaseDate
                })
                self.setsIterator = self.sets.makeIterator()
                completion?(true)

            case let .failure(error):
                self.delegate?.loaded(error: error)
                completion?(false)
            }
        }
    }

    func fetchTypes(completion: ((_ success: Bool) -> Void)? = nil) {
        typeRepository.fetchTypes { result in
            switch result {
            case let .success(types):
                self.types = types.filter { $0 != "instant" }
                self.types.sort(by: { (before, after) -> Bool in
                    before.compare(after) == ComparisonResult.orderedAscending
                })
                self.typesIterator = self.types.makeIterator()
                completion?(true)

            case let .failure(error):
                self.delegate?.loaded(error: error)
                completion?(false)
            }
        }
    }

    func fetchSetsAndTypes(completion: (() -> Void)? = nil) {
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        // Pegar Sets
        fetchSets { _ in
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        // Pegar Tipos
        fetchTypes { _ in
            dispatchGroup.leave()
        }

        dispatchGroup.wait()

        DispatchQueue.main.async {
            completion?()
        }
    }

    func fetchAllCardFrom(set: CardSet, of type: String, with name: String? = nil, and cards: [Card]? = nil, completion: @escaping ([Card]) -> Void) {
        var allCardsOfASet: [Card]

        if let cards = cards {
            allCardsOfASet = cards
        } else {
            allCardsOfASet = [Card]()
        }
        cardRepository.fetchCards(page: currentPage, name: name, setCode: set.code, type: type, orderParameter: CardOrder.type) { [weak self] result, header in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(result):
                // Atualizar o contador
                self.updateCounter(on: result.count)

                // Atualiza o Tipo
                self.currentType = type

                // Adicionar as cartas a um cache local
                allCardsOfASet.append(contentsOf: result)

                // Verificar se o contador ja foi chegou na quantidade de cartas estimadas do set
                if let header = header,
                    self.requestedCardsCounter == header.totalCount {
                    // Reseta o contador e page
                    self.requestedCardsCounter = 0
                    self.currentPage = 1

                    // Finaliza função entrgando cartas
                    if let nextType = self.typesIterator?.next() {
                        self.fetchAllCardFrom(set: set, of: nextType, with: name, and: allCardsOfASet, completion: completion)
                        completion(allCardsOfASet)
                    } else {
                        completion(allCardsOfASet)
                        self.typesIterator = self.types.makeIterator()
                    }
                } else {
                    // Atualiza página e chama denovo
                    self.currentPage += 1
                    self.fetchAllCardFrom(set: set, of: type, with: name, and: allCardsOfASet, completion: completion)
                }

            case let .failure(error):
                self.delegate?.loaded(error: error)
            }
        }
    }

    /// Fetch Cards by set, each time this fuction is called it calls the next set. If the set or types are not loaded this function request both data and only after both the requests are completed it calls it self again.
    ///
    /// This function can generate the error of request limits. If it happens you must call **cleanButKeepSetsAndTypes** or **clean** function.
    ///
    /// - Parameter name: The card name to be used as searching parameter
    func fetchCards(with name: String? = nil) {
        if !isSetsAndTypesLoaded {
            if requestTimeOut > 0 {
                requestTimeOut -= 1
                fetchSetsAndTypes {
                    self.fetchCards(with: name)
                }
            } else {
                delegate?.loaded(error: CardsLoaderError.RequestTimeOut())
            }
            return
        }
        requestTimeOut = 2

        if let set = self.setsIterator?.next(),
            let type = self.typesIterator?.next() {
            currentSet = set
            fetchAllCardFrom(set: set, of: type, with: name) { [weak self] cards in
                guard let self = self else {
                    return
                }
                if !cards.isEmpty {
                    self.currentSet = set
                    self.cards.append(contentsOf: cards)
                    self.delegate?.loaded(cards: cards, forType: self.currentType!, andSet: self.currentSet!, from: self)
                } else {
                    self.fetchCards(with: name)
                }
            }
        }
    }

    func updateCounter(on numberOfCards: Int) {
        if currentPage == 1 {
            requestedCardsCounter = numberOfCards
        } else {
            requestedCardsCounter += numberOfCards
        }
    }
}
