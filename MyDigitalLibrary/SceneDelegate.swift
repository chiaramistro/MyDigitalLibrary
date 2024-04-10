//
//  SceneDelegate.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 02/04/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let dataController = DataController(modelName: "MyDigitalLibrary")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        dataController.load()
        
        let tabController = window?.rootViewController as! UITabBarController
        let booksTabNavontroller = tabController.viewControllers?[0] as! UINavigationController
        let booksTabViewController = booksTabNavontroller.topViewController as! BooksTabViewController
        booksTabViewController.dataController = dataController
        
        let authorsTabNavontroller = tabController.viewControllers?[1] as! UINavigationController
        let authorsTabViewController = authorsTabNavontroller.topViewController as! AuthorsCollectionViewController
        authorsTabViewController.dataController = dataController
    }

}

