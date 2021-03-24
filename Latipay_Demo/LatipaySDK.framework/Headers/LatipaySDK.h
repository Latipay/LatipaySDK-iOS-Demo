//
//  LatipaySDK.h
//  LatipaySDK
//
//  Created by Tonny on 2017/9/11.
//  Copyright © 2017年 Tonny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CompletionErrorBlock)(NSDictionary<NSString *, NSString *> *_Nullable result, NSError *_Nullable error);
typedef void(^PaymentResultBlock)(NSDictionary<NSString *, NSString *> *_Nonnull result);

typedef NS_ENUM(NSInteger, PaymentStatus) {
    kPaymentStatusPaid = 0,
    kPaymentStatusUnpaid = 10,
    kPaymentStatusPending = 20,
    kPaymentStatusNeedQueryServer = 30
};

@interface LatipaySDK : NSObject

/**
 * Unsafe method, please consider to create a transaction in your back-end server first,
 * and then call payWith(host:nonce:wechatUniversalLink:completion) to launch wechat and alipay app to pay
 *
 * This method is used only for debug
 */
+ (void)setupWithApiKey:(NSString *_Nonnull)apiKey userId:(NSString *_Nonnull)userId walletId:(NSString *_Nonnull)walletId wechatUniversalLink:(NSString *_Nonnull)universalLink __deprecated_msg("please consider to create a transaction in your back-end server first, and then call payWith(host:nonce:wechatUniversalLink:completion) to launch wechat and alipay app to pay");

/**
 * Unsafe method, please consider to create a transaction in your back-end server first,
 * and then call payWith(host:nonce:wechatUniversalLink:completion) to launch wechat and alipay app to pay
 *
 * This method is used only for debug
 */
+ (void)pay:(NSDictionary<NSString *, NSString *> *_Nonnull)order completion:(_Nonnull CompletionErrorBlock)completion __deprecated_msg("please consider to create a transaction in your back-end server first, and then call payWith(host:nonce:wechatUniversalLink:completion) to launch wechat and alipay app to pay");

/**
 * Once a transaction was created in your back-end server, call this method to launch wechat and alipay app to pay
 */
+ (void)payWithHost:(NSString *_Nonnull)host nonce:(NSString *_Nonnull)nonce wechatUniversalLink:(NSString *_Nonnull)universalLink completion:(_Nonnull CompletionErrorBlock)completion;

/**
 * Check payment result for wechatpay
 */
+ (BOOL)processPaymentResultWithUserActivity:(NSUserActivity *_Nonnull)userActivity completion:(_Nonnull PaymentResultBlock)completion;

/**
 * Check payment result for alipay
 */
+ (void)processPaymentResultWithUrl:(NSURL *_Nonnull)url completion:(_Nonnull PaymentResultBlock)completion;

@end
