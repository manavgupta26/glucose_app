//
//  SceneDelegate.swift
//  GlucoWise
//
//  Created by iOS Development on 04/12/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        //guard let _ = (scene as? UIWindowScene) else { return }
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            // Replace "YourStoryboardName" with the name of the storyboard you're testing
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateInitialViewController()
            
            window.rootViewController = initialViewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    
    }

    func sceneWillResignActive(_ scene: UIScene) {
     
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
     
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    
    }


}

