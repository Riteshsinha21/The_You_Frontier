//
//  AppDelegate.swift
//  The_You_Frontier
//
//  Created by Chawtech on 22/12/23.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 2.0)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        GMSServices.provideAPIKey(kGoogleApiKey)
        GMSPlacesClient.provideAPIKey(kGoogleApiKey)
        
        checkToLoadScreen()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    
    func checkToLoadScreen(){
        var token =  kUserDefaults.string(forKey: AppKeys.token)
        if token == nil{
            switchLoginVC()
        }
        else{
            if token != "Invalid" {
                switchToHomeVC()
                
            }else {
                switchLoginVC()
                
            }
        }
    }



    func switchToHomeVC() {
        
        let vc = TabBarVC.instantiate(fromAppStoryboard: .map)
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            self.window?.rootViewController = vc
        }
    }
    
    func switchLoginVC() {
        let vc = LoginVC.instantiate(fromAppStoryboard: .main)
//        let navVC = SwipeableNavigationController(rootViewController: vc)
//        navVC.setNavigationBarHidden(true, animated: false)
//        self.window?.rootViewController = navVC
        let nc = UINavigationController.init(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        
        nc.setNavigationBarHidden(false, animated: false)
        
    }
    
    
    

}

