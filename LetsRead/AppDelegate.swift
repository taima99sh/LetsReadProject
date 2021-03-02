//
//  AppDelegate.swift
//  Let's Read
//
//  Created by taima on 2/23/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import AVFoundation

import IQKeyboardManagerSwift

extension UIStoryboard{
   static let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
        
    var window: UIWindow?
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var rootNavigationViewController: UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //UIApplication.shared.supportedInterfaceOrientations(for: window)
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient,
                                                         mode: AVAudioSession.Mode.moviePlayback,
                                                          options: [.mixWithOthers])
       IQKeyboardManager.shared.enable = true
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
}

