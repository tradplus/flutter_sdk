//
//  TPFNative.m
//  tradplus_sdk
//
//  Created by xuejun on 2022/7/13.
//

#import "TPFNative.h"
#import <TradPlusAds/TradPlusAds.h>
#import "TradplusSdkPlugin.h"

@interface TPFNative()<TradPlusADNativeDelegate>

@property (nonatomic,strong)TradPlusAdNative *native;
@end

@implementation TPFNative

- (instancetype)init
{
    self = [super init];
    if (self) {
        [TradPlus setLogLevel:MSLogLevelOff];
        self.native = [[TradPlusAdNative alloc] init];
        self.native.delegate = self;
    }
    return self;
}

- (void)setTemplateRenderSize:(CGSize)size
{
    MSLogTrace(@"%s size:%@", __PRETTY_FUNCTION__,@(size));
    [self.native setTemplateRenderSize:size];
}

- (void)setAdUnitID:(NSString * _Nonnull)adUnitID
{
    MSLogTrace(@"%s adUnitID:%@", __PRETTY_FUNCTION__,adUnitID);
    [self.native setAdUnitID:adUnitID];
}

- (void)loadAd
{
    MSLogTrace(@"%s", __PRETTY_FUNCTION__);
    [self.native loadAd];
}

- (void)loadAds:(NSInteger)adsCount
{
    MSLogTrace(@"%s %ld", __PRETTY_FUNCTION__,(long)adsCount);
    [self.native loadAds:adsCount];
}

- (TradPlusAdNativeObject *)getReadyNativeObject
{
    return self.native.getReadyNativeObject;
}

- (void)showWithClassName:(Class)viewClass subview:(UIView *)adView sceneId:(NSString *)sceneId
{
    MSLogTrace(@"%s sceneId:%@", __PRETTY_FUNCTION__,sceneId);
    [self.native showADWithRenderingViewClass:viewClass subview:adView sceneId:sceneId];
}

- (void)showWithRenderer:(TradPlusNativeRenderer *)renderer subview:(UIView *)adView sceneId:(NSString *)sceneId
{
    MSLogTrace(@"%s sceneId:%@", __PRETTY_FUNCTION__,sceneId);
    [self.native showADWithNativeRenderer:renderer subview:adView sceneId:sceneId];
}

- (void)setCustomMap:(NSDictionary *)dic
{
    MSLogTrace(@"%s dic:%@", __PRETTY_FUNCTION__,dic);
    id segmentTag = dic[@"segment_tag"];
    if([segmentTag isKindOfClass:[NSString class]])
    {
        self.native.segmentTag = segmentTag;
    }
    self.native.dicCustomValue = dic;
}

- (void)entryAdScenario:(nullable NSString *)sceneId
{
    MSLogTrace(@"%s sceneId:%@", __PRETTY_FUNCTION__,sceneId);
    [self.native entryAdScenario:sceneId];
}

- (BOOL)isAdReady
{
    MSLogTrace(@"%s", __PRETTY_FUNCTION__);
    return self.native.isAdReady;
}

- (NSInteger)getLoadedCount
{
    MSLogTrace(@"%s", __PRETTY_FUNCTION__);
    return self.native.readyAdCount;
}

- (void)setCustomAdInfo:(NSDictionary *)customAdInfo
{
    MSLogTrace(@"%s", __PRETTY_FUNCTION__);
    self.native.customAdInfo = customAdInfo;
}

- (NSString *)eventName:(NSString *)event
{
    return [NSString stringWithFormat:@"native_%@",event];
}

#pragma mark - TradPlusADNativeDelegate

///AD???????????? ???????????????????????????????????? ????????????????????????????????????
- (void)tpNativeAdLoaded:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"loaded"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///AD????????????
///tpNativeAdOneLayerLoad:didFailWithError?????????????????????????????????
- (void)tpNativeAdLoadFailWithError:(NSError *)error
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, error);
    NSString *eventNam = [self eventName:@"loadFailed"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:nil error:error];
}

///AD??????
- (void)tpNativeAdImpression:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"impression"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///AD????????????
- (void)tpNativeAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    MSLogTrace(@"%s %@ %@", __PRETTY_FUNCTION__, adInfo,error);
    NSString *eventNam = [self eventName:@"showFailed"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///AD?????????
- (void)tpNativeAdClicked:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"clicked"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///v7.6.0+?????? ??????????????????
- (void)tpNativeAdStartLoad:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"startLoad"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///?????????????????????????????????????????????????????????
///v7.6.0+?????????????????????????????????tpNativeAdLoadStart:(NSDictionary *)adInfo;
- (void)tpNativeAdOneLayerStartLoad:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"oneLayerStartLoad"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///AD?????????
- (void)tpNativeAdClose:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"closed"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///bidding??????
- (void)tpNativeAdBidStart:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"bidStart"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///bidding?????? error = nil ????????????
- (void)tpNativeAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error
{
    MSLogTrace(@"%s %@ %@", __PRETTY_FUNCTION__, adInfo,error);
    NSString *eventNam = [self eventName:@"bidEnd"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:error];
}

///?????????????????????????????????????????????????????????
- (void)tpNativeAdOneLayerLoaded:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"oneLayerLoaded"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///???????????????????????????????????????????????????????????????????????????????????????
- (void)tpNativeAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"oneLayerLoadedFail"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:error];
}

///????????????????????????
- (void)tpNativeAdAllLoaded:(BOOL)success
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, @(success));
    NSString *eventNam = [self eventName:@"allLoaded"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:nil error:nil exp:@{@"success":@(success)}];
}

///???????????? v7.8.0+
- (void)tpNativeAdVideoPlayStart:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"playStart"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///???????????? v7.8.0+
- (void)tpNativeAdVideoPlayEnd:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"playEnd"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

- (void)tpNativeAdIsLoading:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
    NSString *eventNam = [self eventName:@"isLoading"];
    [TradplusSdkPlugin callbackWithEventName:eventNam adUnitID:self.native.unitID adInfo:adInfo error:nil];
}

///???????????????????????????????????? v6.8.0+
- (void)tpNativePasterDidPlayFinished:(NSDictionary *)adInfo
{
    MSLogTrace(@"%s %@", __PRETTY_FUNCTION__, adInfo);
}
@end
