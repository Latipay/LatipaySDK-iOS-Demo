# LatipaySDK-iOS-Demo

Using Latipay sdk to intergrate Alipay and Wechatpay

1. Download framework and drag it into your project

2. Setup Latipay info

```swift

LatipaySDK.setup(apiKey: "XXXXXX", userId: "XXXXXX", walletId: "XXXXXX", scheme: "latipay")

```

3. App user purchases with wechat or alipay app

```swift

let para = [
    "payment_method": "wechat",  //or alipay
    "amount": "1",
    "merchant_reference":"a reference",
    "product_name": "Fossil Women's Rose Goldtone Blane Watch",
    "price": "175.00"
    ]

LatipaySDK.pay(order: para) { (latipayOrder, error) in

    //...save orderId for check later
    
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

