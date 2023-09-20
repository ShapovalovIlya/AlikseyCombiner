//
//  ViewController.swift
//  AlikseyCombiner
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    private let viewModel: ViewModel
    private let mainView: MainView
    private lazy var dataSource = DataSource(collectionView: mainView.collectionView)
    private var cancellable: Set<AnyCancellable> = .init()

    init(
        viewModel: ViewModel,
        mainView: MainView
    ) {
        self.viewModel = viewModel
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
        mainView.collectionView.dataSource = dataSource
        mainView.collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$posts
            .sink(receiveValue: dataSource.update(_:))
            .store(in: &cancellable)
       
        viewModel.viewDidLoad()
    }


}

//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

