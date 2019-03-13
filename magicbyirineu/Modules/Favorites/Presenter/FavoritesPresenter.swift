import Foundation
import UIKit

class FavoritesPresenter: NSObject {
    var router: FavoritesRouter
    var interactor: FavoritesInteractor
    var view: FavoritesViewController

    init(router: FavoritesRouter, interactor: FavoritesInteractor, view: FavoritesViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view

        super.init()

        self.view.screen.collectionView.dataSource = self
        self.view.screen.collectionView.delegate = self
        self.view.presenter = self
    }
}

extension FavoritesPresenter: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        var numberOfSections = 0

        if numberOfSections == 0 {
            view.set(status: .empty)
        } else {
            view.set(status: .normal)
        }

        return numberOfSections
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 0
    }

    func collectionView(_: UICollectionView, cellForItemAt _: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension FavoritesPresenter: UICollectionViewDelegate {}
