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
    private var favoriteHouses = [String:House]()
    private var dataSource: DataSource?
    
    
    //MARK: - Inicializers
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 125)
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)// Le dices al copilador que es inaccesible para todas las versiones de iOS
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
        
        collectionView.dataSource = dataSource
        // Añadir el dataSource a collection.
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Array(favoriteHouses.values))
        
        dataSource?.apply(snapshot)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceive), name: .didToggleFavourite, object: nil)
    }
    
    // obtener el evento.
    @objc
    func didReceive(_ notification: Notification) {
        
        guard let info = notification.userInfo, let house = info["house"] as? House,
        var snapshot = dataSource?.snapshot() else {
            return
        }
        
        if let foundHouse = favoriteHouses[house.rawValue] {
            favoriteHouses.removeValue(forKey: foundHouse.rawValue)
            snapshot.deleteItems([foundHouse])
        } else {
            favoriteHouses[house.rawValue] = house
            snapshot.appendItems([house])
        }
        
        
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
}
