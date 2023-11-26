//
//  SceneDelegate.swift
//  TaskListApp
//
//  Created by brubru on 23.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let widowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: widowScene)
		window?.rootViewController = UINavigationController(rootViewController: TaskListViewController())
		window?.makeKeyAndVisible()
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
        StorageManager.shared.saveContext()
	}
}

