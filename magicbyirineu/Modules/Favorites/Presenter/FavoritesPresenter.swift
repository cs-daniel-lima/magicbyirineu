import Foundation
import UIKit

class FavoritesPresenter: NSObject {
    var router: FavoritesRouter
    var interactor: CardListInteractor
    var view: FavoritesViewController

    init(router: FavoritesRouter, interactor: CardListInteractor, view: FavoritesViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view

        super.init()

        self.view.presenter = self
    }
}
