//
//  FavoriteHouseListViewController.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 12/9/24.
//

import UIKit

final class FavoriteHouseListViewController: UICollectionViewController {
    // MARK: - Datasource
    typealias DataSource = UICollectionViewDiffableDataSource<Int, House>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, House>
    
    // MARK: - Model
    private let favoriteHouses = [House]()
    private var dataSource: DataSource?
    
    
    //MARK: - Inicializers
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 125)
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)// Le dices al copilador que es inaccesible
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let registration = UICollectionView.CellRegistration<FavoriteHouseCollectionViewCell, House>(cellNib: UINib(nibName: FavoriteHouseCollectionViewCell.idenfifier, bundle: nil) ) {cell, _ , house in cell.configure(with: house)}
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, house in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: house)
            
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(favoriteHouses)
        
        dataSource?.apply(snapshot)
    }
    
    
}
