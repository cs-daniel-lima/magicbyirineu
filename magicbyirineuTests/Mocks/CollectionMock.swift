import UIKit

@testable import magicbyirineu

class CollectionViewControllerMock: UIViewController {
    let screen: CollectionMock

    required init(mockView: CollectionMock) {
        screen = mockView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        screen.setupCollectionViewCells()
        screen.collectionView.delegate = screen
        screen.collectionView.dataSource = screen
        screen.collectionView.reloadData()
    }
}

final class CollectionMock: UIView {
    let layout: UICollectionViewFlowLayout

    init(mockLayout: UICollectionViewFlowLayout) {
        layout = mockLayout

        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 540))

        setupView()
    }

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)

        view.backgroundView?.backgroundColor = UIColor.red
        view.backgroundColor = .red

        return view
    }()

    func setupCollectionViewCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionMock: CodeView {
    func buildViewHierarchy() {
        addSubview(collectionView)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
        }
    }

    func additionalSetup() {
        backgroundColor = .cyan
    }
}

extension CollectionMock: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3, height: 118)
    }
}

extension CollectionMock: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 100
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        cell.backgroundColor = .yellow

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)

        view.backgroundColor = .white

        return view
    }
}
