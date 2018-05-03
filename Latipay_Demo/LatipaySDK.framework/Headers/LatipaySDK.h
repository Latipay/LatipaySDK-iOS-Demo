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
    kPaymentStatusNeedQueryFromYourOwnServer = 30
};

@interface LatipaySDK : NSObject

#ifdef DEBUG
+ (void)setupDemoAccountOnlyWorkForAlipay;
#endif

+ (void)setupWithApiKey:(NSString *_Nonnull)apiKey userId:(NSString *_Nonnull)userId walletId:(NSString *_Nonnull)walletId;

+ (void)pay:(NSDictionary<NSString *, NSString *> *_Nonnull)order completion:(_Nonnull CompletionErrorBlock)completion;

+ (void)processPaymentResultWithUrl:(NSURL *_Nonnull)url completion:(_Nonnull PaymentResultBlock)completion;


@end
