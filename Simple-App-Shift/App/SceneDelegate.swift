//
//  SceneDelegate.swift
//  Simple-App-Shift
//
//  Created by Евгений Глоба on 7/5/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        if isLoggedIn == false {
            self.window?.rootViewController = Builder.createRegViewController()
        } else {
            self.window?.rootViewController = Builder.createMainViewController()
        }
        self.window?.makeKeyAndVisible()
    }
}

