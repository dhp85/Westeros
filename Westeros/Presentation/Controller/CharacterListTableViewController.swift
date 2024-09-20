//
//  CharacterlistTableViewController.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 19/9/24.
//

import UIKit

final class CharacterListTableViewController: UITableViewController {
    
    //MARK - TableView DataSource
    typealias DataSource = UITableViewDiffableDataSource<Int, GOTCharacter>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, GOTCharacter>
    
    
    //MARK: - Model
    
    private let networkModel: NetworkModel
    private var dataSource: DataSource?
    
    // MARK: - Components
    
    private var activityIndicator: UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }
    
    // MARK: - Initializers
    
    init(networkModel: NetworkModel = .shared) {
        self.networkModel = networkModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = activityIndicator
        
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, character in
            let cell = UITableViewCell()
            var configuration = cell.defaultContentConfiguration()
            configuration.text = character.fullName
            cell.contentConfiguration = configuration
            return cell
            
        }
        
        tableView.dataSource = dataSource
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        
        // siempre que utilicemos self hay que utilizar weak como en el codigo de aqui abajo.
        networkModel.getAllCharacters{ [weak self] result in
            switch result {
                
            case let .success(characters):
                snapshot.appendItems(characters)
                self?.dataSource?.apply(snapshot)
            case .failure(_):
                break
            }
        }


    }


    
}
