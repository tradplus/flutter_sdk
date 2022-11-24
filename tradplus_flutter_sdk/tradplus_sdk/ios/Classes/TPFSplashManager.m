//
//  TPFSplashManager.m
//  tradplus_sdk
//
//  Created by xuejun on 2022/7/19.
//

#import "TPFSplashManager.h"
#import <TradPlusAds/TradPlusAds.h>

@interface TPFSplashManager()

@property (nonatomic,strong)NSMutableDictionary <NSString *,TPFSplash *>*splashAds;
@end

@implementation TPFSplashManager

+ (TPFSplashManager *)sharedInstance
{
    static TPFSplashManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TPFSplashManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.splashAds = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result
{
    NSString *adUnitID = call.arguments[@"adUnitID"];
    if([@"splash_load" isEqualToString:call.method])
    {
        [self loadAdWithAdUnitID:adUnitID methodCall:call];
    }
    else if([@"splash_ready" isEqualToString:call.method])
    {
        [self isAdReadyWithAdUnitID:adUnitID result:result];
    }
    else if([@"splash_show" isEqualToString:call.method])
    {
        [self showAdWithAdUnitID:adUnitID methodCall:call];
    }
    else if([@"splash_setCustomAdInfo" isEqualToString:call.method])
    {
        [self setCustomAdInfoWithAdUnitID:adUnitID methodCall:call];
    }
}

- (TPFSplash *)getSplashWithAdUnitID:(NSString *)adUnitID
{
    if([self.splashAds valueForKey:adUnitID])
    {
        return self.splashAds[adUnitID];
    }
    return nil;
}

- (void)loadAdWithAdUnitID:(NSString *)adUnitID methodCall:(FlutterMethodCall*)call
{
    TPFSplash *splash = [self getSplashWithAdUnitID:adUnitID];
    if(splash == nil)
    {
        
        splash = [[TPFSplash alloc] init];
        [splash setAdUnitID:adUnitID];
        self.splashAds[adUnitID] = splash;
    }
    NSDictionary *extraMap = call.arguments[@"extraMap"];
    if(extraMap != nil)
    {
        id customMap = extraMap[@"customMap"];
        if(customMap != nil && [customMap isKindOfClass:[NSDictionary class]])
        {
            [splash setCustomMap:customMap];
        }
    }
    [splash loadAd];
}

- (void)isAdReadyWithAdUnitID:(NSString *)adUnitID result:(FlutterResult)result

{
    BOOL isReady = NO;
    TPFSplash *splash = [self getSplashWithAdUnitID:adUnitID];
    if(splash != nil)
    {
        isReady = splash.isAdReady;
    }
    else
    {
        MSLogInfo(@"splash adUnitID:%@ not initialize",adUnitID);
    }
    result(@(isReady));
}

- (void)showAdWithAdUnitID:(NSString *)adUnitID methodCall:(FlutterMethodCall*)call
{
    TPFSplash *splash = [self getSplashWithAdUnitID:adUnitID];
    if(splash != nil)
    {
        NSString *className = call.arguments[@"className"];
        [splash showAdWithClassName:className];
    }
    else
    {
        MSLogInfo(@"splash adUnitID:%@ not initialize",adUnitID);
    }
}

- (void)setCustomAdInfoWithAdUnitID:(NSString *)adUnitID methodCall:(FlutterMethodCall*)call
{
    TPFSplash *splash = [self getSplashWithAdUnitID:adUnitID];
    NSDictionary *customAdInfo = call.arguments[@"customAdInfo"];
    if(splash != nil)
    {
        [splash setCustomAdInfo:customAdInfo];
    }
    else
    {
        MSLogInfo(@"splash adUnitID:%@ not initialize",adUnitID);
    }
}
@end
