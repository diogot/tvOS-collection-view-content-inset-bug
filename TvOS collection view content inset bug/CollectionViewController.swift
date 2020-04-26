//
//  CollectionViewController.swift
//  TvOS collection view prefetch bug
//
//  Created by Diogo on 25/04/20.
//  Copyright © 2020 Diogo Tridapalli. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    lazy var dataSource: UICollectionViewDiffableDataSource<Section, Int> =
        makeDataSource(collectionView: collectionView)


    let items: Int
    init(items: Int) {
        self.items = items
        super.init(collectionViewLayout: makeLayout())
        tabBarItem.title = "\(items) items"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<items))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

enum Section {
    case main
}

private func makeDataSource(collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Int> {
    collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)

    let dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
        (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in

        // Get a cell of the desired kind.
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TextCell.reuseIdentifier,
            for: indexPath) as? TextCell else { fatalError("Cannot create new cell") }

        // Populate the cell with our item description.
        cell.label.text = "\(identifier)"
        cell.contentView.backgroundColor = .blue
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.label.textAlignment = .center
        cell.label.font = UIFont.preferredFont(forTextStyle: .title1)

        // Return the cell.
        return cell
    }

    return dataSource
}

private func makeLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(88))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    let spacing = CGFloat(10)
    group.interItemSpacing = .fixed(spacing)

    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = spacing
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
}
