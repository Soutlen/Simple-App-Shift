//
//  Builder.swift
//  Simple-App-Shift
//
//  Created by Евгений Глоба on 7/5/25.
//

import UIKit

final class Builder {
    private init() {}
    
    static func createRegViewController() -> UIViewController {
        let viewController = RegView()
        let presenter = RegPresenter(view: viewController)
        viewController.presenter = presenter
        let navController = UINavigationController(rootViewController: viewController)
        
        return navController
    }
    
    static func createMainViewController() -> UIViewController {
        let viewController = MainView()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(view: viewController, network: networkManager)
        viewController.presenter = presenter
        let navController = UINavigationController(rootViewController: viewController)
        
        return navController
    }
    
}
