//
//  TPInterstitial.m
//  tradplus_sdk
//
//  Created by xuejun on 2022/7/19.
//

#import "TPFOfferwall.h"

#import <TradPlusAds/TradPlusAds.h>
#import "TradplusSdkPlugin.h"

@interface TPFOfferwall()<TradPlusADOfferwallDelegate>

@property (nonatomic,strong)TradPlusAdOfferwall *offerwall;
@end

@implementation TPFOfferwall

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.offerwall = [[TradPlusAdOfferwall alloc] init];
        self.offerwall.delegate = self;
    }
    return self;
}

- (void)setAdUnitID:(NSString * _Nonnull)adUnitID
{
    MSLogTrace(@"%s adUnitID:%@", __PRETTY_FUNCTION__,adUnitID);
    [self.offerwall setAdUnitID:adUnitID];
}

- (void)setCustomMap:(NSDictionary *)dic
{
    MSLogTrace(@"%s dic:%@", __PRETTY_FUNCTION__,dic);
    id segmentTag = dic[@"segment_tag"];
    if([segmentTag isKindOfClass:[NSString class]])
    {
        self.offerwall.segmentTag = segmentTag;
    }
    self.offerwall.dicCustomValue = dic;
}

- (void)loadAd
{
    MSLogTrace(@"%s ", __PRETTY_FUNCTION__);
    [self.offerwall loadAd];
}

- (void)showAdWithSceneId:(nullable NSString *)sceneId
{
    MSLogTrace(@"%s sceneId:%@", __PRETTY_FUNCTION__,sceneId);
    [self.offerwall showAdWithSceneId:sceneId];
}

- (void)entryAdScenario:(nullable NSString *)sceneId
{
    MSLogTrace(@"%s sceneId:%@", __PRETTY_FUNCTION__,sceneId);
    [self.offerwall entryAdScenario:sceneId];
}

- (BOOL)isAdReady
{
    MSLogTrace(@"%s ", __PRETTY_FUNCTION__);
    return self.offerwall.isAdReady;
}

- (void)getCurrency
{
    MSLogTrace(@"%s ", __PRETTY_FUNCTION__);
    [self.offerwall getCurrencyBalance];
}

- (void)spendWithAmount:(int)amount
{
    MSLogTrace(@"%s amount:%@", __PRETTY_FUNCTION__,@(amount));
    [self.offerwall spendCurrency:amount];
}

- (void)awardWithAmount:(int)amount
{
    MSLogTrace(@"%s amount:%@", __PRETTY_FUNCTION__,@(amount));
    [self.offerwall awardCurrency:amount];
}

- (void)setUserId:(NSString *)userId
{
    MSLogTrace(@"%s userId:%@", __PRETTY_FUNCTION__,userId);
    [self.offerwall setUserId:userId];
}

- (void)setCustomAdInfo:(NSDictionary *)customAdInfo
{
    MSLogTrace(@"%s", __PRETTY_FUNCTION__);
    self.offerwall.customAdInfo = customAdInfo;
}

- (NSString *)eventName:(NSString *)event
{
    return [NSString stringWithFormat:@"offerwall_%@",event];
}

#pragma mark - TradPlusADOfferwallDelegate

///AD???????????? ???????????????????????????????????? ????????????????????????????????????
- (void)tpOfferwallAdLoaded:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"loaded"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:adInfo error:nil];
}

///AD????????????
///tpOfferwallAdOneLayerLoaded:didFailWithError?????????????????????????????????
- (void)tpOfferwallAdLoadFailWithError:(NSError *)error
{
    MSLogTrace(@"%s error:%@", __PRETTY_FUNCTION__, error);
    NSString *eventNam = [self eventName:@"loadFailed"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:nil error:error];
}

///AD??????
- (void)tpOfferwallAdImpression:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"impression"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:adInfo error:nil];
}

///AD????????????
- (void)tpOfferwallAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    MSLogTrace(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"showFailed"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:adInfo error:error];
}

///AD?????????
- (void)tpOfferwallAdClicked:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"clicked"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:adInfo error:nil];
}

///AD??????
- (void)tpOfferwallAdDismissed:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"closed"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:adInfo error:nil];
}

///??????????????????
- (void)tpOfferwallAdStartLoad:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"startLoad"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:adInfo error:nil];
}

///?????????????????????????????????????????????????????????
- (void)tpOfferwallAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"oneLayerStartLoad"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:adInfo error:nil];
}

///?????????????????????????????????????????????????????????
- (void)tpOfferwallAdOneLayerLoaded:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"oneLayerLoaded"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:adInfo error:nil];
}

///???????????????????????????????????????????????????????????????????????????????????????
- (void)tpOfferwallAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    MSLogTrace(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"oneLayerLoadedFail"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:adInfo error:error];
}

///????????????????????????
- (void)tpOfferwallAdAllLoaded:(BOOL)success
{
    MSLogTrace(@"%s success:%@", __PRETTY_FUNCTION__, @(success));
    NSString *eventNam = [self eventName:@"allLoaded"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:nil error:nil exp:@{@"success":@(success)}];
}

- (void)tpOfferwallAdIsLoading:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s adInfo:%@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"isLoading"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:adInfo error:nil];
}

///userID ???????????? error = nil ??????
- (void)tpOfferwallSetUserIdFinish:(NSError *)error
{
    MSLogTrace(@"%s error:%@", __PRETTY_FUNCTION__, error);
    NSString *eventNam = [self eventName:@"setUserIdFinish"];
    bool success = (error == nil);
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:nil error:nil exp:@{@"success":@(success)}];
}

///?????????????????????????????????
- (void)tpOfferwallGetCurrencyBalance:(NSDictionary *)response error:(NSError *)error
{
    MSLogTrace(@"%s error:%@", __PRETTY_FUNCTION__, error);
    if(error == nil)
    {
        NSInteger amount = 0;
        if(response[@"amount"])
        {
            amount = [response[@"amount"] integerValue];
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:response];
        [dic removeObjectForKey:@"amount"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
        NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *eventNam = [self eventName:@"currency_success"];
        if(msg == nil)
        {
            msg = @"";
        }
        [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:nil error:nil exp:@{@"amount":@(amount),@"msg":msg}];
    }
    else
    {
        NSData *data = [NSJSONSerialization dataWithJSONObject:response options:0 error:nil];
        NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *eventNam = [self eventName:@"currency_failed"];
        if(msg == nil)
        {
            msg = @"";
        }
        [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:nil error:nil exp:@{@"msg":msg}];
    }
}

//?????????????????????????????????
- (void)tpOfferwallSpendCurrency:(NSDictionary *)response error:(NSError *)error
{
    MSLogTrace(@"%s error:%@", __PRETTY_FUNCTION__, error);
    if(error == nil)
    {
        NSInteger amount = 0;
        if(response[@"amount"])
        {
            amount = [response[@"amount"] integerValue];
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:response];
        [dic removeObjectForKey:@"amount"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
        NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *eventNam = [self eventName:@"spend_success"];
        if(msg == nil)
        {
            msg = @"";
        }
        [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:nil error:nil exp:@{@"amount":@(amount),@"msg":msg}];
    }
    else
    {
        NSData *data = [NSJSONSerialization dataWithJSONObject:response options:0 error:nil];
        NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *eventNam = [self eventName:@"spend_failed"];
        if(msg == nil)
        {
            msg = @"";
        }
        [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:nil error:nil exp:@{@"msg":msg}];
    }
}

//?????????????????????????????????
- (void)tpOfferwallAwardCurrency:(NSDictionary *)response error:(NSError *)error
{
    MSLogTrace(@"%s error:%@", __PRETTY_FUNCTION__, error);
    if(error == nil)
    {
        NSInteger amount = 0;
        if(response[@"amount"])
        {
            amount = [response[@"amount"] integerValue];
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:response];
        [dic removeObjectForKey:@"amount"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
        NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(msg == nil)
        {
            msg = @"";
        }
        NSString *eventNam = [self eventName:@"award_success"];
        [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:nil error:nil exp:@{@"amount":@(amount),@"msg":msg}];
    }
    else
    {
        NSData *data = [NSJSONSerialization dataWithJSONObject:response options:0 error:nil];
        NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *eventNam = [self eventName:@"award_failed"];
        if(msg == nil)
        {
            msg = @"";
        }
        [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.offerwall.unitID adInfo:nil error:nil exp:@{@"msg":msg}];
    }
}

@end
