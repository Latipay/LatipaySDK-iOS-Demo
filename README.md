# LatipaySDK-iOS-Demo

Using Latipay sdk to intergrate Alipay and Wechatpay

1. Download framework and drag it into your project

2. Setup Latipay info

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions 
    launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
  
    LatipaySDK.setup(apiKey: "", userId: "", walletId: "", scheme: "latipay")
    
    return true
}
```

3. App user purchases with wechat or alipay app

```swift
@objc func wechatPay(_ btn: UIButton?) {
    let para = ["payment_method": LatipayMethod.wechatpay.rawValue,
                "amount": "1",
                "merchant_reference":"reference",
                "product_name": "Fossil Women's Rose Goldtone Blane Watch",
                "price": "175.00"]

    LatipaySDK.pay(order: para) {[weak self] (result, error) in
        //...save orderId for check later
    }
}
```

4. Wechat or Alipay app will send the result of payment to your app through scheme.

```swift
func application(_ app: UIApplication, open url: URL, 
    options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    LatipaySDK.processLatipayRequest(url: url) { (latipayOrder, error) in

        //save orderId and status into server for customer
    }
    return true
}
```

