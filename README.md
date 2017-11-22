# LatipaySDK-iOS-Demo

Using [Latipay](http://www.latipay.net) sdk to intergrate Alipay and Wechatpay

![](screenshot/home.png)

### 1. Download framework and drag it into your project

![](screenshot/framework.png)


for iOS 9.0 and later, please add the following [Launch Services Key](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/LaunchServicesKeys.html) into info.plist;

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>alipay</string>
    <string>weixin</string>
</array>
```

### 2. Setup Latipay info, [you can get apiKey here](https://merchant.latipay.co.nz/user/regist.action)

```swift

LatipaySDK.setup(apiKey: "XXXXXX", userId: "XXXXXX", walletId: "XXXXXX", scheme: "latipay")

```

### 3. App user purchases with goods using wechat or alipay app

```swift

let para = [
    "payment_method": "wechat",  //or alipay
    "amount": "0.01",
    "merchant_reference":"a reference",
    "product_name": "Fossil Women's Rose Goldtone Blane Watch",
    "callback_url": "https://youwebsite.com/pay_callback"
    ]

LatipaySDK.pay(order: para) { (latipayOrder, error) in

    //...save orderId for check later
    
}

```

### 4. Wechat or Alipay app will send the result of payment to your app through scheme.

```swift
func application(_ app: UIApplication, open url: URL, 
    options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    
    LatipaySDK.processLatipayRequest(url: url) { (latipayOrder, error) in

        //save orderId and status into server
    }
    
    return true
}
```

### 5. No more steps in App




