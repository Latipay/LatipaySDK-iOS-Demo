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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /*
         This demo can only run in Device!
         
         what you must have before using this SDK
         for alipay: api_key, user_id, wallet_idK
         for wechat: api_key, user_id, wallet_id, wechat_app_id, wechat_universal_link
        
         and then find in this project and replace it to your own data
         1. your.website.com
         2. your_wechat_app_id
         3. your_wallet_id
         */
        
        //you can setup your account for a quick demo, it's not recommend use this method in production
        #if DEBUG
        LatipaySDK.setup(withApiKey: "", userId: "", walletId: "", wechatUniversalLink: "")
        #endif
        
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        LatipaySDK.processPaymentResult(with: userActivity, completion: dealWith(result:))
    }
    
    //< iOS 9
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        LatipaySDK.processPaymentResult(with: url, completion: dealWith(result:))
        return true
    }
    
    //>= iOS 9
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        LatipaySDK.processPaymentResult(with: url, completion: dealWith(result:))
        return true
    }
    
    private func dealWith(result: [String: String]) {
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

