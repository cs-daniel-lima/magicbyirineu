import Kingfisher
import UIKit

class CardListPresenter: NSObject {
    // MARK: Private

    private var query: String?

    var isFirstLoad: Bool = true

    var router: CardListRouter
    var interactor: CardListInteractor!
    var view: CardListViewController!

    init(router: CardListRouter, interactor: CardListInteractor, view: CardListViewController) {
        self.router = router
        self.interactor = interactor
        self.view = view

        super.init()

        self.view.screen.collectionView.dataSource = self
        self.view.screen.collectionView.delegate = self
        self.view.screen.searchBar.delegate = self
        self.interactor.delegate = self

        setup()
    }

    func setup() {
        view.screen.collectionView.register(cellType: CardCollectionViewCell.self)
        view.screen.collectionView.register(cellType: SubSectionCollectionViewCell.self)
        view.screen.collectionView.register(supplementaryViewType: SetCollectionReusableView.self, ofKind: UICollectionView.elementKindSectionHeader)
    }
}

extension CardListPresenter: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        let numberOfSections = interactor.numberOfSets()

        if numberOfSections == 0, isFirstLoad == false {
            view.set(status: .empty)
        } else if view.isQuering == false {
            view.set(status: .normal)
        }
        isFirstLoad = false
        return numberOfSections
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !interactor.isSearching {
            return interactor.numberOfElementsForSet(setIndex: section)

        } else {
            let keys = interactor.objectsBySet.keys.compactMap { (set) -> CardSet in
                set
            }
            let set = keys[section]

            guard let objectList = self.interactor.objectsBySet[set] else {
                Logger.logError(in: self, message: "Could not get objectList in CardSet: \(set)")
                return 0
            }

            return objectList.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()

        guard let object = self.interactor.getElementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
            Logger.logError(in: self, message: "Could not get an object")
            return cell
        }

        if let category = object as? String {
            let subsectionCell: SubSectionCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

            subsectionCell.label.text = category.capitalized

            cell = subsectionCell

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

            cell = cardCell
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view: SetCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)

        view.label.text = interactor.sets[indexPath.section].name

        return view
    }

    func collectionView(_: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt _: IndexPath) {
        if let cardCell = cell as? CardCollectionViewCell {
            cardCell.backgroundImage.image = nil
        }
    }
}

extension CardListPresenter: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let object = self.interactor.getElementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
            Logger.logError(in: self, message: "Could not get an object")
            return
        }

        guard let card = object as? Card else {
            Logger.log(in: self, message: "Couldn't cast object to type Card")
            return
        }

        router.goToCardDetail(cards: interactor.cardOrganizer.getAllCards(), selectedCard: card)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let currentSet = collectionView.numberOfItems(inSection: indexPath.section) - 1

        if indexPath.row == currentSet, !interactor.waitingAPIResponse {
            interactor.paginate()
        }
    }
}

extension CardListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let object = self.interactor.getElementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
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

extension CardListPresenter: CardListInteractorDelegate {
    func didLoad(error _: Error) {}

    func didLoad() {
        DispatchQueue.main.async {
            self.view.reloadData()
            self.view.set(status: .normal)
        }
    }
}

extension CardListPresenter: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        query = nil
        view.screen.collectionView.reloadData()
        view.screen.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            self.query = text
            view.set(status: .searching)
            guard let query = self.query else {
                Logger.logError(in: self, message: "Query is nil")
                return
            }
            view.screen.collectionView.reloadData()
            view.screen.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            interactor.fetchSearchingCards(cardName: query)
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text == nil || searchBar.text?.isEmpty ?? false {
            interactor.cancelSearch()
            view.screen.collectionView.reloadData()
            view.screen.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
}
