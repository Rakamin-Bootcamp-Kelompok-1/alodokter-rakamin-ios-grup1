//
//  AppDelegate.swift
//  Alodokter_bootcamp
//
//  Created by Abdul Aziz on 20/11/21.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let baseViewController = BaseViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        let initialView : UINavigationController = UINavigationController(rootViewController: SplashScreenViewController())
               self.window = UIWindow(frame: UIScreen.main.bounds)
               self.window?.rootViewController = initialView
               self.window?.makeKeyAndVisible()
      
        IQKeyboardManager.shared().isEnabled = true
        
        // Custom Font for Navigation Bar
        guard let navBarTitleFont = UIFont(name: "Nunito-SemiBold", size: 17) else {
            fatalError("""
                    Failed to load the "Nunito-SemiBold" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
                )
        }
        
        let navBarTitleAttributes = [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: navBarTitleFont)]
        
        UINavigationBar.appearance().titleTextAttributes = navBarTitleAttributes
        UIBarButtonItem.appearance().setTitleTextAttributes(navBarTitleAttributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(navBarTitleAttributes, for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes(navBarTitleAttributes, for: .focused)

        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

