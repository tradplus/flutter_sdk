#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tradplus_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tradplus_sdk'
  s.version          = '1.0.4'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
Tradplus SDK Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'
  
  s.frameworks = 'NetworkExtension','DeviceCheck'

  s.pod_target_xcconfig =   {'OTHER_LDFLAGS' => ['-lObjC']}
  
  s.libraries = 'c++', 'z', 'sqlite3', 'xml2', 'resolv', 'bz2.1.0','bz2','xml2','resolv.9','iconv','c++abi'

  s.vendored_frameworks = 'TradPlusFrameworks/**/*.framework'
  
  s.vendored_libraries = ['TradPlusFrameworks/GDTMob/GDTSDK/*.a','TradPlusFrameworks/Kidoz/KidozSDK/*.a','TradPlusFrameworks/YouDao/YDSDK/*.a',]
  
  s.resources = ['TradPlusFrameworks/**/*.bundle',"Assets/**/*"]

#     s.dependency 'FBAudienceNetwork','6.11.2'
#     s.dependency 'Google-Mobile-Ads-SDK','9.7.0'
#     s.dependency 'UnityAds','4.2.1'
#     s.dependency 'AppLovinSDK','11.4.3'
#     s.dependency 'TapjoySDK','12.10.0'
#     s.dependency 'VungleSDK-iOS', '6.11.0'
#     s.dependency 'IronSourceSDK','7.2.3.1'
#     s.dependency 'AdColony','4.9.0'
#     s.dependency 'InMobiSDK/Core' ,'10.0.8'
#     s.dependency 'MintegralAdSDK' ,'7.1.8.0'
#     s.dependency 'MintegralAdSDK/All','7.1.8.0'
#     s.dependency 'KSAdSDK', '3.3.27'
#     s.dependency 'KlevinAdSDK', '2.9.0.216'
#     s.dependency 'SigmobAd-iOS', '4.2.1'
#     s.dependency 'GDTMobSDK', '4.13.81'
#     s.dependency 'Ads-Global/BUAdSDK_Compatible', '4.8.0.6'
#     s.dependency 'Ads-CN/BUAdSDK_Compatible', '4.8.1.0'
#     s.dependency 'YDADSDK', '2.16.12'
#     s.dependency 'MaioSDK', '1.6.2'
#     s.dependency 'myTargetSDK', '5.15.2'
#     s.dependency 'smaato-ios-sdk', '21.7.6'
#     s.dependency 'smaato-ios-sdk/Banner', '21.7.6'
#     s.dependency 'smaato-ios-sdk/Interstitial', '21.7.6'
#     s.dependency 'smaato-ios-sdk/RewardedAds', '21.7.6'
#     s.dependency 'ChartboostSDK', '8.5.0.2'
#     s.dependency 'StartAppSDK', '4.7.2'
#     s.dependency 'Fyber_Marketplace_SDK', '8.1.5'
#     s.dependency 'SuperAwesome', '8.3.8'
#     s.dependency 'BaiduMobAdSDK', '4.881'
#     s.dependency 'OgurySdk', '2.1.0'
#     s.dependency 'HyBid', '2.14.0'
#     s.dependency 'YandexMobileAds', '5.1.0'
#     s.dependency 'WechatOpenSDK_UnPay', '1.8.7.1'
#     s.dependency 'ChartboostHelium', '2.11.0'

  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }
end
