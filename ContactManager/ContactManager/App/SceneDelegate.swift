//
//  SceneDelegate.swift
//  ContactManager
//
//  Created by Effie on 1/5/24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = ListContactViewControllerFactory.make()
        window.makeKeyAndVisible()
        self.window = window
    }
}
