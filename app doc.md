# Latipay iOS/Android app api

* get ready for your userId, walletId, apiKey
* add WeChat/Alipay SDK to your iOS/Android project

## 1 Latipay Transaction Interface

```
POST https://api.latipay.net/v2/transaction
Content-Type: application/json;charset=UTF-8
```

Parameters:

```
 {
    amount = "0.01";
    "callback_url" = "https://your.web.server.com/latipay/callback";
    ip = "127.0.0.1";
    "merchant_reference" = "1536896240_218803";
    "payment_method" = wechat; //or alipay
    "product_name" = Ticket;
    "return_url" = "";
    signature = 113f2677ea0c5195f11195e3d3f6bf9d26c0132c5d00d7f3ac90ddcaab3fb0c3;
    source = ios;
    "user_id" = U000000000;
    version = "2.0";
    "wallet_id" = W000000000;
}
```

SHA-256 HMAC Signature

```
//js demo

const message = Object.keys(data)
  .filter(item => data[item] != null && data[item] != undefined && data[item] !== '')
  .sort()
  .map(item => `${item}=${data[item]}`)
  .join('&')
  .concat(api_key)
  
const signature = SHA-256HMAC(message, api_key)
```

Response:

```
{
    code = 0;
    "host_url" = "https://api-staging.latipay.net/v2/apporder";
    message = SUCCESS;
    nonce = 113f2620180914113721adad7415bf7a449e91101626113e4e;
    signature = 59bdeea148b904318fc4efd421290e275fcf9e8892f77118d68c16d884ff7575;
}
```

## 2 Latipay Payment Interface（WeChat）

```
GET {host_url}/{nonce}
```

Response:

```
{
    code = 0;
    gatewaydata =     {
        appid = wx897971482bfb7a1d;
        noncestr = 620d5650f8f84fd797d6fee00d79201b;
        package = "Sign=WXPay";
        partnerid = 38491213;
        prepayid = wx14113722507404a0d34fc1c93805674256;
        sign = 93F909191F11E2B592500B70F6BB81A9;
        timestamp = 1536896242;
        tradeType = APP;
    };
    message = SUCCESS;
    ...
}
```
WeChat SDK download: https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=11_1

Integrate WeChat SDK to make payment: https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=8_5

```
PayReq *request = [[[PayReq alloc] init] autorelease];
request.partnerId = @"38491213";
request.prepayId= @"wx14113722507404a0d34fc1c93805674256";
request.package = @"Sign=WXPay";
request.nonceStr= @"620d5650f8f84fd797d6fee00d79201b";
request.timeStamp= @"1536896242";
request.sign= @"93F909191F11E2B592500B70F6BB81A9";
[WXApi sendReq：request];
```

## 2 Latipay Payment Interface（Alipay）

```
GET {host_url}/{nonce}
```

Response:

```
{
    code = 0;
    gatewaydata =     {
        "_input_charset" = "UTF-8";
        body = 5399;
        currency = NZD;
        "forex_biz" = FP;
        "notify_url" = "https://api-staging.latipay.net/notify/alipay";
        "out_trade_no" = S2018091400000014;
        partner = 2088121611339960;
        "payment_type" = 1;
        "product_code" = "NEW_WAP_OVERSEAS_SELLER";
        "secondary_merchant_id" = W000000902;
        "secondary_merchant_industry" = 5399;
        "secondary_merchant_name" = "NZD-P1";
        "seller_id" = 2088121611339960;
        service = "mobile.securitypay.pay";
        sign = "bFh6J4iCAKqkOvX3F9n1qLeTMJOJAprlSF%2F%2F%2FVcp0S%2FrPRo3uTZSANIJvEHdwtoO5tbdjeF%2Fc2M4ACaoP0xoa%2BjO506iYrDbNnDzTVmC%2BEm2P%2BLIg0jXakKztCodZtZz7h3Wmv6IAnYP552p6z%2BW6e1ipiKz8PKzYHhilefAfnE%3D";
        "sign_type" = RSA;
        subject = Ticket;
        "total_fee" = "0.01";
    };
	...
}
```

Aliapy SDK download: https://opendocs.alipay.com/open/54/104509

Integrate Alipay SDK to make payment: https://opendocs.alipay.com/open/204/105295

```
NSMutableString *orderString = [NSMutableString string];
    
[[gateway allKeys] enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [orderString appendFormat:@"%@%@=%@", idx>0?@"&":@"", key, gateway[key]];
}];

[[AlipaySDK defaultService] payOrder:orderString fromScheme:SCHEME callback:nil];
```

## 3 Payment-Result-Interface

https://doc.latipay.net/v2/latipay-hosted-online.html#5-Payment-Result-Interface

