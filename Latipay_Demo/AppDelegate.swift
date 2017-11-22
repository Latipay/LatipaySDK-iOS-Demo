//
//  AppDelegate.swift
//  Latipay_Demo
//
//  Created by Tonny on 13/11/17.
//  Copyright © 2017 Latipay. All rights reserved.
//

import UIKit
import LatipaySDK_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        LatipaySDK.setupDemoAccount()
        
        //or load latipay account (api_key, user_id, wallet_id) from plist
        
        //LatipaySDK.setup(apiKey: "your latipay apikey", userId: "your latipay userId", walletId: "your latipay walletId")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return self.application(application, open: url)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        LatipaySDK.processPayRequest(url: url) { (result, error) in
            print("latipay result", result as Any, error as Any)
            
            //save orderId and status into server for customer
            if let order = result?["latipay_info"] as? [String: Any], let id = order["orderId"] as? String, let status = order["status"] as? String {
                UIAlertView(title: "orderId: \(id)", message: "status: \(status)", delegate: nil, cancelButtonTitle: "Cancel").show()
            }
        }
        return true
    }
}

