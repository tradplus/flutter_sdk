//
//  TPFInterstitialManager.h
//  tradplus_sdk
//
//  Created by xuejun on 2022/7/19.
//

#import <Flutter/Flutter.h>
#import "TPFOfferwall.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPFOfferwallManager : NSObject

+ (TPFOfferwallManager *)sharedInstance;

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;

- (TPFOfferwall *)getOfferwallWithAdUnitID:(NSString *)adUnitID;
@end

NS_ASSUME_NONNULL_END
