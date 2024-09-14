//
//  FavoriteHouseCollectionViewCell.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 12/9/24.
//

import UIKit

final class FavoriteHouseCollectionViewCell: UICollectionViewCell {
    // MARK: - Identifier
    static let idenfifier = String(describing: FavoriteHouseCollectionViewCell.self)
    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    // MARK: - Configuration
    func configure(with house: House) {
        houseNameLabel.text = house.rawValue
    }
    
}
