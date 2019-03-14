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

        self.view.screen.collectionView.dataSource = self
        self.view.screen.collectionView.delegate = self
        self.view.presenter = self

        self.interactor.delegate = self

        setup()
    }

    func setup() {
        view.screen.collectionView.register(cellType: CardCollectionViewCell.self)
        view.screen.collectionView.register(cellType: SubSectionCollectionViewCell.self)
        view.screen.collectionView.register(supplementaryViewType: SetCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
        
        self.interactor.fetchCards()
    }
}

extension FavoritesPresenter: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        let numberOfSections = interactor.numberOfSets()

        if numberOfSections == 0 {
            view.set(status: .empty)
        } else {
            view.set(status: .normal)
        }

        return numberOfSections
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.numberOfElementsForSet(setIndex: section)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let object = self.interactor.getElementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
            Logger.logError(in: self, message: "Could not get an object")
            return
        }

        guard let card = object as? Card else {
            Logger.log(in: self, message: "Couldn't cast object to type Card")
            return
        }

        router.goToCardDetail(cards: interactor.cardOrganizer.getAllCards(), selectedCard: card, sets: interactor.sets)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let object = self.interactor.elementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
            Logger.logError(in: self, message: "Could not get an object")
            return UICollectionViewCell()
        }
        
        if let category = object as? String {
            let subsectionCell: SubSectionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

            subsectionCell.label.text = category.capitalized

            return subsectionCell

        } else if let card = object as? Card {
            let cardCell: CardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

            cardCell.backgroundImage.image = nil

            cardCell.type = .homeScreenCell

            if let imageURL = card.imageUrl {
                let url = URL(string: imageURL)
                cardCell.backgroundImage.kf.setImage(with: url)
                cardCell.cardTitle.text = ""

            } else {
                if let foreignNames = card.foreignNames,
                    !foreignNames.isEmpty {
                    if let foreignImageUrl = foreignNames[0].imageUrl {
                        let url = URL(string: foreignImageUrl)
                        cardCell.backgroundImage.kf.setImage(with: url)
                    }
                } else {
                    cardCell.backgroundImage.image = UIImage(named: "cartaVerso")
                    cardCell.cardTitle.text = card.name
                }
            }

            return cardCell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view: SetCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        
        view.label.text = interactor.set(of: indexPath.section).name
        
        return view
    }

    func collectionView(_: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt _: IndexPath) {
        if let cardCell = cell as? CardCollectionViewCell {
            cardCell.backgroundImage.image = nil
        }
    }
}

extension FavoritesPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let object = self.interactor.elementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
            Logger.logError(in: self, message: "Could not get the object from CardSet at index:\(indexPath.section)")
            return CGSize.zero
        }

        if object is String {
            return CGSize(width: UIScreen.main.bounds.width, height: 16)
        } else {
            return CGSize(width: collectionView.frame.size.width / 3, height: (118 / 320) * collectionView.frame.size.width)
        }
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, referenceSizeForHeaderInSection _: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
}

extension FavoritesPresenter: CardListInteractorDelegate {
    func didLoad(error: Error) {
        print(error)
    }

    func didLoad() {
        DispatchQueue.main.async {
            self.view.screen.collectionView.reloadData()
            self.view.set(status: .normal)
        }
    }
}
