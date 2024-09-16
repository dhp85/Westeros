//
//  SceneDelegate.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 10/9/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Desempaquetamos la scene
        guard let scene = (scene as? UIWindowScene) else { return }
        // Creamos un objeto window
        let window = UIWindow(windowScene: scene)
        // Instanciamos un tab bar
        let tabBarController = UITabBarController()
        // Instanciamos nuestra lista de casas
        let houseListViewController = HouseListViewController()
         
        houseListViewController.tabBarItem = UITabBarItem(title: "Houses", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        // configuramos el tabBarItem
        let navigationController = UINavigationController(rootViewController: houseListViewController)
        let favoritesViewController = FavoriteHouseListViewController()
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        tabBarController.viewControllers = [navigationController, favoritesNavigationController]
        // Asignamos el primer view controller
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}

