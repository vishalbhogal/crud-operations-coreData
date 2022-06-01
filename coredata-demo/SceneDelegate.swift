//
//  SceneDelegate.swift
//  coredata-demo
//
//  Created by Vishal, Bhogal (B.) on 01/06/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let rootVC = ViewController()
        let navigationVC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}
