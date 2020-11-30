//
//  AppDelegate.swift
//  Unsplash
//
//  Created by Danny Narvaez on 11/25/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		prepareUI()
		return true
	}
	
	private func prepareUI() {
		UINavigationBar.appearance().barTintColor = UIColor.white
		UINavigationBar.appearance().tintColor = UIColor.black
		UINavigationBar.appearance().isTranslucent = false
		UINavigationBar.appearance().shadowImage = UIImage()
		UINavigationBar.appearance().backgroundColor = UIColor.white
		UITabBar.appearance().barTintColor = UIColor.white
		UITabBar.appearance().tintColor = UIColor.black
		UITabBar.appearance().isTranslucent = false
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
	}

}
