import Foundation

class FavoritesRouter {
    var presenter: FavoritesPresenter!

    init() {
        let viewController = FavoritesViewController(title: "Favorites")
        
        let cardRepository = RealmCards()
        let cardSetRepository = RealmSets()
        let typeRepository = RealmTypes()
        
        let fetchLoader = CardsLoader(cardRepository: cardRepository, cardSetRepository: cardSetRepository, typeRepository: typeRepository)
        let searchLoader = CardsLoader(cardRepository: cardRepository, cardSetRepository: cardSetRepository, typeRepository: typeRepository)
        
        let fetchOrganizer = CardOrganizer()
        let searchOrganizer = CardOrganizer()
        
        let interactor = CardListInteractor(fetchLoader: fetchLoader, searchLoad: searchLoader, fetchCardOrganizer: fetchOrganizer, searchCardOrganizer: searchOrganizer)

        presenter = FavoritesPresenter(router: self, interactor: interactor, view: viewController)
    }
}
