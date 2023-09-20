//
//  DataSource.swift
//  AlikseyCombiner
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import UIKit

final class DataSource: UICollectionViewDiffableDataSource<Int, Post> {
    let cellProvider: (UICollectionView, IndexPath, Post) -> UICollectionViewCell? = { collectionView, indexPath, post in
        collectionView.dequeueConfiguredReusableCell(
            using: cellRegistration,
            for: indexPath,
            item: post
        )
    }
    
    static let cellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, Post> = .init { cell, indexPath, post in
        var config = UIListContentConfiguration.cell()
        config.text = post.title
        config.secondaryText = post.body
        config.image = UIImage(systemName: "person")
        cell.contentConfiguration = config
    }
    
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    func update(_ posts: [Post]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Post>()
        snapshot.appendSections([0])
        snapshot.appendItems(
            posts,
            toSection: 0
        )
        apply(snapshot)
    }
}
