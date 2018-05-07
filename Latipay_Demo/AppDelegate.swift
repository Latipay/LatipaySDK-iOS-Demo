//
//  AppDelegate.swift
//  Latipay_Demo
//
//  Created by Tonny on 13/11/17.
//  Copyright © 2017 Latipay. All rights reserved.
//

import UIKit
import LatipaySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /*
         what you must have before using this SDK
         for alipay: api_key, user_id, wallet_id
         for wechat: api_key, user_id, wallet_id, wechat app id
         */
        
        
        //demo account perhaps canot work properly.
        LatipaySDK.setupDemoAccountOnlyWorkForAlipay()
        
        //TODO: setup your own latipay account
//        LatipaySDK.setup(withApiKey: "", userId: "", walletId: "")
        
        
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

    //< iOS 9
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        self.dealwithLatipay(url)
        return true
    }
    
    //>= iOS 9
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        self.dealwithLatipay(url)
        return true
    }
    
    func dealwithLatipay(_ url: URL) {
        LatipaySDK.processPaymentResult(with: url) { (result) in
            print("latipay result", result)
            guard let statusString = result["status"],
                let stausInt = Int(statusString),
                let status = PaymentStatus(rawValue: stausInt) else {
                    return
            }
            
            let merchant_reference = result["merchant_reference"]
            let transactionId = result["transaction_id"]
            let method = result["payment_method"]
            
            if (status == .paid) {
                print("paid")
            }else if (status == .unpaid) {
                print("unpaid")
            }else {
                print("need load the payment result from your own server.")
            }
        }
    }
}

