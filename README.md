# LatipaySDK for iOS app

Using [Latipay](http://www.latipay.net) sdk to intergrate Alipay payment solution. Wechat pay coming soon.

![](screenshot/home.png?)

### 1. Download Latipay framework in this demo and drag it into your project

![](screenshot/framework.png)


for iOS 9.0 and later, please add the following [Launch Services Key](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/LaunchServicesKeys.html) into info.plist;

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>alipay</string>
    <string>weixin</string>
</array>
```

### 2. Setup Latipay info, [you can get apiKey here](https://merchant.latipay.net)

```swift

LatipaySDK.setup(withApiKey: "XXXXXX", userId: "XXXXXX", walletId: "XXXXXX")

```

### 3. App user purchases with goods using alipay app

```swift

let para = [
    "payment_method": "alipay",
    "amount": "0.01",
    "merchant_reference":"12312-12312312",
    "product_name": "Fossil Women's Rose Goldtone Blane Watch",
    "callback_url": "https://youwebsite.com/pay_callback"
    ]

LatipaySDK.payOrder(para) { (result, error) in

    //...save paymentId for check later
    
}

```

### 4. Alipay app will send the result of payment to your app through scheme.

```swift
func application(_ app: UIApplication, open url: URL, 
    options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    
    LatipaySDK.processPayRequest(with: url) { (result) in

        //save orderId and status into server
    }
    
    return true
}
```

### 5. In your web server, please support the below api for callback when payment successful or failed

```
POST https://yourwebsite.com/pay_callback
```

Parameters:

```json
{
  "transaction_id": "43cb917ff8a6",
  "merchant_reference": "dsi39ej430sks03",
  "amount": "120.00",
  "currency": "NZD",
  "payment_method": "alipay",
  "pay_time": "2017-07-07 10:53:50",
  "status" : "paid",
  "signature": "14d5b06a2a5a2ec509a148277ed4cbeb3c43301b239f080a3467ff0aba4070e3",
}
```

[More info about this notify api](http://doc.latipay.net/v2/latipay-hosted-online.html#Payment-Result-Asynchronous-Notification)


TODO Wechat pay
Add Wechat App id in URL Scheme
