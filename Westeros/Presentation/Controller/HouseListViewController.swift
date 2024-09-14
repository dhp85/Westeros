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
    private let houses: [House] = House.allCases// es igual House.allCases a una array de todas las opciones del tipo House
    // Al declarar una variable como nula, el compilador infiere que su valor inical es nil
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
        dataSoruce = DataSource(tableView: tableView) {tableView, indexPath, house in
            // Obtenemos una celda reusable y la castamos a
            // el tipo de celda que queremos representar
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HouseTableViewCell.identifier, for: indexPath) as? HouseTableViewCell else {
                // Si no podemos desempaquetarla
                // retornamos una celda en blanco
                return UITableViewCell()
            }
            cell.configure(witch: house)
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
    }
}

extension HouseListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
