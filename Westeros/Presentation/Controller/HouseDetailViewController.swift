//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 16/9/24.
//

import UIKit

// AnyObject los usamos para decirle al compilador.
// que este protocolo solo lo pueden usar reference types.
// no value types.
protocol FavouriteHouseDelegate: AnyObject {
    func didToggleFavourite(for house: House)
}

final class HouseDetailViewController: UIViewController {
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var houseImageView: UIImageView!
    
    private let house: House
    private var isFavourite: Bool
    weak var favouriteHouseDelegate: FavouriteHouseDelegate?
    
    init(house: House, isFavorite: Bool) {
        self.house = house
        self.isFavourite = isFavorite
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) // Para que al inicializador vea que es inaccesible
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationItem()

      
    }

}

// MARK: - View Configuration
private extension HouseDetailViewController {
    func configureView() {
        houseNameLabel.text = house.rawValue
        
        guard let imageURL = house.imageURL else {
            return
        }
        
        houseImageView.setImage(url: imageURL)
    }
    
    func configureNavigationItem() {
        navigationItem.rightBarButtonItem = makeRightBarButtonItem()
    }
    
    func makeRightBarButtonItem() -> UIBarButtonItem {
        UIBarButtonItem(image: makeFavoriteStar(isFavourite: isFavourite), style: .plain, target: self, action: #selector(didTapFavouriteItem))
        
    }
    
    // El sender es el componente que dicta la accion, seria el UIBarButtonItem y en este caso pone Any.
    // con el @obj le decimos al compilador que el metodo esta disponible en objetive c
    @objc
    func didTapFavouriteItem(_ sender: Any) {
        isFavourite.toggle()
        favouriteHouseDelegate?.didToggleFavourite(for: house)
        navigationItem.setRightBarButton(makeRightBarButtonItem(), animated: true)
        NotificationCenter.default.post(name: .didToggleFavourite, object: self, userInfo: ["house": house])
    }
    
    func makeFavoriteStar(isFavourite: Bool) -> UIImage? {
        isFavourite
        ? UIImage(systemName: "star.fill")// si es favorito creamos una imagen con relleno.
        : UIImage(systemName: "star") // si no es favorito la imagen no se rellena.
    }
    
}
