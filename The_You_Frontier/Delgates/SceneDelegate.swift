//
//  SceneDelegate.swift
//  The_You_Frontier
//
//  Created by Chawtech on 22/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        checkToLoadScreen()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func checkToLoadScreen(){
        var token =  kUserDefaults.string(forKey: AppKeys.token)
        if token == nil{
            switchLoginScreen()
        }
        else{
            if token != "Invalid" {
                switchToHomeScreen()
                
            }else {
                switchLoginScreen()
                
            }
        }
    }
    
    //MARK:- Home Screen
    func switchToHomeScreen(){
        let vc = TabBarVC.instantiate(fromAppStoryboard: .map)
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            TYF_AppDelegate.window?.rootViewController = vc
        }
    }
    
    //MARK:- Login Screen
    func switchLoginScreen() {
        
        let vc = LoginVC.instantiate(fromAppStoryboard:.main)
        let nc = UINavigationController.init(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        nc.setNavigationBarHidden(false, animated: false)
        
//        let navVC = SwipeableNavigationController(rootViewController: vc)
//        navVC.setNavigationBarHidden(true, animated: false)
//        self.window?.rootViewController = navVC
    }

}

