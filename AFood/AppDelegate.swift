//
//  AppDelegate.swift
//  AFood
//
//  Created by 許博皓 on 2023/1/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 設定標籤列 (tab bar
        let tabBarAppearance = UITabBarAppearance() //建立UITabBarAppearance的物件
        tabBarAppearance.configureWithOpaqueBackground() //設定背景不透明
        
        UITabBar.appearance().tintColor = UIColor(named: "NavigationBarTitle") //設定背景顏色
        UITabBar.appearance().standardAppearance = tabBarAppearance //指定這個物件為標籤列的標準外觀
        
        // 請求使用者允許推播通知
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in

            if granted {
                print("User notifications are allowed.")
            } else {
                print("User notifications are not allowed.")
            }
        }
        
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

