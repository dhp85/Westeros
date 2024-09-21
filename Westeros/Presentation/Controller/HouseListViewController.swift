//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 12/9/24.
//

import UIKit


// 1º Le pone final para decirle al copilador que no va ha ver subclases de esta clase. No va ser heredada.
final class HouseListViewController: UITableViewController {
    
    
    // MARK: - Table View DataSource
    typealias DataSource = UITableViewDiffableDataSource<Int, House>// Objeto que maneja datos y proveer celdas a TableView.Con el generico <> defines como van
    // a ser las celdas
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, House> // Una representacion de los dato en una vista. Para actualizar los datos bien procedentes de una API o en local.tipo generico que tiene dos tipos asociados, siempre el identificador de arriba.
    
    // MARK: - Model
    // Constante privada
    private let houses: [House] = House.allCases
    // es igual House.allCases a una array de todas las opciones del tipo House
    // Al declarar una variable como nula, el compilador infiere que su valor inical es nil
    private var favouriteHouses = [String: House]()
    private var dataSoruce: DataSource?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. Registrar la celda custom
        // Registramos
        
        tableView.register(UINib(nibName: HouseTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HouseTableViewCell.identifier) // instanciamos el archivo .xib a traves de su nombre.
                                           // cada vez que TableView se encuentre este identificador
                                           // tiene que instanciar el .xib que le especificamos en el UI
        
        // 2. Configurar el data source
        dataSoruce = DataSource(tableView: tableView) { [weak self] tableView, indexPath, house in
            // Obtenemos una celda reusable y la castamos a
            // el tipo de celda que queremos representar
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HouseTableViewCell.identifier, for: indexPath) as? HouseTableViewCell else {
                // Si no podemos desempaquetarla
                // retornamos una celda en blanco
                return UITableViewCell()
            }
            let foundHouse = self?.favouriteHouses[house.rawValue]
            let isFavourite = foundHouse != nil
            cell.configure(witch: house, isFavourite: isFavourite)
            return cell
        }
        // 3. Añadir el data source al table view
        tableView.dataSource = dataSoruce
        // 4. Crear un snapshot con los objetos a representar
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        // para crear secciones y nombrarlas habria que crear un enum, cambiar el tipo en los typalias en este caso cambiar por el tipo de enum creado con las diferentes secciones y meterlos dentro de la array,ejemplo [.Casas,.mascotas]. Esta en el video de la clase 3 Ios fundamentos en el 1:50.18.
        snapshot.appendItems(houses)
        
        // 5. Aplicar el snapshot al data source para añadir los objetos
        dataSoruce?.apply(snapshot)
        
        NetworkModel.shared.getAllCharacters { result in
            switch result {
            case let .success(Characters):
                print(Characters)
            case let .failure(error):
                print(error)
            }
        }
        
        LocalDataModel.save(value: "some_token")
    }
}

//MARK: - Table View Delegate
// Con esta extension le damos tamaño a nuestra celda.
extension HouseListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    // el delegado que nos dice que la celda ha sido presionada.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let house = houses[indexPath.row]
        let foundHouse = favouriteHouses[house.rawValue]
        let isFavourite = foundHouse != nil
        let detailViewController = HouseDetailViewController(house: house, isFavorite: isFavourite)
        detailViewController.favouriteHouseDelegate = self
        navigationController?.show(detailViewController, sender: self)
    }
}

extension HouseListViewController: FavouriteHouseDelegate {
    func didToggleFavourite(for house: House) {
        // Eliminamos la casa que nos pasan por parametro
        // del diccionario
        if let foundHouse = favouriteHouses[house.rawValue] {
            favouriteHouses.removeValue(forKey: foundHouse.rawValue)
        } else {
            //Añadimos la casa que nos pasan por parametro
            favouriteHouses[house.rawValue] = house
        }
        
        // para refrescar los datos.
        guard var snapshot = dataSoruce?.snapshot() else {
            return
        }
        // Refrescamos la celda cuyo modelo es house que nos pasan.
        // Por parametro
        snapshot.reloadItems([house])
        dataSoruce?.apply(snapshot, animatingDifferences: false)
        
    }
    
    
}
