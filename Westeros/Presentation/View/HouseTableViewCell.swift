//
//  HouseTableViewCell.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 12/9/24.
//

import UIKit
// el final es para que sepamos que esta clase no va ser heredada.
final class HouseTableViewCell: UITableViewCell {
    // MARK: Identifier
    // Usando String(decribing:) vamos a crear un string
    // de la siguiente forma "HouseTableViewCell"
    // static let identifier = "HouseTableViewCell"
    static let identifier = String(describing: HouseTableViewCell.self)
    // MARK: - Outlets
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var houseLabel: UILabel!
    
    // MARK: - Configuration
    func configure(witch house: House, isFavourite: Bool) {
        // RawValue lo utilizamos para obtener
        // la representacion del String
        houseLabel.text = house.rawValue
        favouriteImageView.isHidden = !isFavourite
        
        guard let imageURL = house.imageURL else {
            return
        }
        houseImageView.setImage(url: imageURL)
    }
}
