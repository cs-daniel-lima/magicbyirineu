import Foundation
import UIKit

class CardDetailPresenter: NSObject {
    var router: CardDetailRouter?
    let view: CardDetailViewController
    let interactor: CardDetailInteractor

    var pageSize: CGSize {
        if let layout = self.view.screen.collectionView.collectionViewLayout as? MagicCarouselFlowLayout {
            return CGSize(width: layout.minimumLineSpacing, height: layout.itemSize.height)
        } else {
            return CGSize.zero
        }
    }

    init(interactor: CardDetailInteractor, view: CardDetailViewController) {
        self.view = view
        self.interactor = interactor

        super.init()

        self.view.presenter = self

        self.view.screen.collectionView.dataSource = self
        self.view.screen.collectionView.delegate = self

        setup()
    }

    func setup() {
        view.screen.collectionView.register(cellType: CardCollectionViewCell.self)
    }

    public func scroolToSelectedCard() {
        let index = interactor.indexOfSelectedCard()
        view.screen.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }

    public func collectionViewDidScroolToItemAt(indexPath: IndexPath) {
        interactor.changeSelectedCard(index: indexPath.row)
    }
}

extension CardDetailPresenter: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return interactor.cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell: CardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        let card = interactor.cards[indexPath.row]

        cardCell.backgroundImage.image = nil
        cardCell.type = .detailScreenCell

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
}

extension CardDetailPresenter: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_: UIScrollView) {
        let centerPosition = CGPoint(x: view.screen.bounds.midX, y: view.screen.bounds.midY)
        let relatedPositionInCollectionView = view.screen.convert(centerPosition, to: view.screen.collectionView)

        if let indexPath = self.view.screen.collectionView.indexPathForItem(at: relatedPositionInCollectionView) {
            collectionViewDidScroolToItemAt(indexPath: indexPath)
        }
    }
}
