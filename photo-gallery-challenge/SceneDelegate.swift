//
//  SceneDelegate.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 1/02/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowsScene)
        let navigationController = UINavigationController()
        let _ = HomeRouter(navigation: navigationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

