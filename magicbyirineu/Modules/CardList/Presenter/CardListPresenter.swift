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
        } else {
            view.set(status: .normal)
        }
        isFirstLoad = false
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.interactor.numberOfElementsForSet(setIndex: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:UICollectionViewCell = UICollectionViewCell()
        
        guard let object = self.interactor.elementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SetCollectionReusableView", for: indexPath) as? SetCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        cell.label.text = self.interactor.set(of: indexPath.section).name
        
        return cell
    }

    func collectionView(_: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt _: IndexPath) {
        if let cardCell = cell as? CardCollectionViewCell {
            cardCell.backgroundImage.image = nil
        }
    }
}

extension CardListPresenter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let object = self.interactor.elementInSet(setIndex: indexPath.section, elementIndex: indexPath.row) else {
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
        
        if(indexPath.row == currentSet && !interactor.waitingAPIResponse){
            
            self.interactor.fetchCards()
        }
    }
}

extension CardListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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

extension CardListPresenter: CardListInteractorDelegate {
    func didLoad(error _: Error) {}

    func didLoad() {
        DispatchQueue.main.async {
            self.view.screen.collectionView.reloadData()
        }
    }
}

extension CardListPresenter: UISearchBarDelegate{
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text == nil || searchBar.text?.isEmpty ?? false {
            self.interactor.cancelSearch()
            self.view.screen.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.view.screen.collectionView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        self.query = nil
        self.interactor.cancelSearch()
        self.view.screen.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        self.view.screen.collectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            self.query = text
            guard let query = self.query else {
                Logger.logError(in: self, message: "Query is nil")
                return
            }
            self.interactor.cancelSearch()
            self.interactor.fetchSearchingCards(cardName: query)
            self.view.screen.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.view.screen.collectionView.reloadData()
        }
    }
}
