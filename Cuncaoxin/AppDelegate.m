//
//  AppDelegate.m
//  Cuncaoxin
//
//  Created by 刘杰cjs on 15/4/17.
//  Copyright (c) 2015年 com.js.cuncaoxin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "AppBaseNavigationController.h"
#import "XGPush.h"
#import "AppThirdPartyPlatformConfig.h"
#import "XGSetting.h"
#import "WelcomeVC.h"
#import "AFNetworking.h"
#import "UIApplication+LJ.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    AFHTTPRequestOperationManager  *manager = [AFHTTPRequestOperationManager manager];
//    NSError * tmpError;
//    NSMutableURLRequest * req=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://xiaoenai.meiriq.com/api/setScore" parameters:@{@"last_score":@(8192)} error:&tmpError];
//    NSDictionary * cookie1Dic = @{
//                                  NSHTTPCookieDomain:@"",
//                                  NSHTTPCookieExpires:[NSDate dateWithTimeIntervalSinceNow:60*60],
//                                  NSHTTPCookiePath:@"/",
//                                  NSHTTPCookieName:@"PHPSESSID",
//                                  
//                                  //NSHTTPCookieValue:@"shdvilh7ugabv98mv15q43ml06"//hq
//                                  NSHTTPCookieValue:@"vpvk15ls6dvihhqa8cdreo9rd4"//lj
//                                  };
//    NSDictionary * cookie2Dic = @{
//                                  NSHTTPCookieDomain:@"",
//                                  NSHTTPCookieExpires:[NSDate dateWithTimeIntervalSinceNow:60*60],
//                                  NSHTTPCookiePath:@"/",
//                                  NSHTTPCookieName:@"SERVER_ID",
//                                  NSHTTPCookieValue:@"1871d63d-d091e0af"//lj
//                                  //NSHTTPCookieValue:@"1871d63d-bba1fb29"//hq
//                                  };
//    
//    NSHTTPCookie * cookie1 =[[NSHTTPCookie alloc] initWithProperties:cookie1Dic];
//    NSHTTPCookie * cookie2 =[[NSHTTPCookie alloc] initWithProperties:cookie2Dic];
//    
//    NSDictionary *headers=[NSHTTPCookie requestHeaderFieldsWithCookies:@[cookie1,cookie2]];
//    
//     [req setValue:[headers objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
//     [req setValue:@"http://xiaoenai.meiriq.com/game/play/3" forHTTPHeaderField:@"Referer"];
//     AFHTTPRequestOperation * requestOperation=  [manager HTTPRequestOperationWithRequest:req success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         
//         NSLog(@"服务器响应:%@",operation.responseString);
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"ERROR 响应:%@  错误:%@",operation.responseString ,error);
//     }];
//    [requestOperation start];
//    
//    return YES;
    //清除角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    MyLog(@"%@",[NSBundle mainBundle ].bundleIdentifier);
    
    NSDictionary * remoteDic = launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    NSString * openUrl = nil;
    if (remoteDic) {
        for (NSString * key in remoteDic.allKeys) {
            if ([[key lowercaseString] isEqualToString:@"zixundizhi"] || [[key lowercaseString] isEqualToString:@"openurl"]) {
                openUrl = remoteDic[key];
                break;
            }
        }
    }
    
    //基础业务配置
    [self basicServiceConfiguration:launchOptions];
    [ShareSDK registerApp:@""];
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:kTencentAppID
                           appSecret:kTencentAppKey
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:kTencentAppID
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:kWXAppID
                           wechatCls:[WXApi class]];
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    if ([UIApplication isFirstOpenOrFirstOpenAfterUpdated]) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        WelcomeVC * welcomvc = [[WelcomeVC alloc]init];
        welcomvc.launchOptions = launchOptions;
        self.window.rootViewController = welcomvc;
    }else{
        MainViewController * mainVC = [[MainViewController alloc]init];
        mainVC.needAnimation = YES;
        if (openUrl) {
            mainVC.remoteSpecifiedUrl = openUrl;
        }
        AppBaseNavigationController * nav = [[AppBaseNavigationController alloc]initWithRootViewController:mainVC];
        nav.navigationBar.barTintColor = kColor(192, 26, 19, 1);
        nav.navigationBar.tintColor = [UIColor whiteColor];
        self.window.rootViewController = nav;
    }
    [UIApplication   sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
#pragma mark 基础业务配置
- (void) basicServiceConfiguration:(NSDictionary * )launchOptions{
    //注册设备
    [self registerForPush];
    
    //初始化 XGPush
    [XGPush startApp:kAPSAppID appKey:kAPSAppKey];
    
//    
//    NSDictionary * notificationDic = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
//    if (notificationDic) {
//        [ApplicationService setApplicationStartUpTrigger:ApplicationStartUpTriggerNotification];
//    }
   
}
#pragma mark ------------------------------------------------------------ 推送相关 -----------------------------------------------------------------------
#pragma mark 注册设备
- (void) registerForPush{
    if (kIOS8_0_OR_LATER) {
        //Types
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        //Actions
        UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
        
        acceptAction.identifier = @"ACCEPT_IDENTIFIER";
        acceptAction.title = @"Accept";
        
        acceptAction.activationMode = UIUserNotificationActivationModeForeground;
        acceptAction.destructive = NO;
        acceptAction.authenticationRequired = NO;
        
        //Categories
        UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
        
        inviteCategory.identifier = @"INVITE_CATEGORY";
        
        [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
        
        [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
        
        NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
        
        
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
}
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
#pragma mark 设备注册回调
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //注册设备
    void (^successBlock)(void) = ^(void){
        //成功之后的处理
       // [LJAlertView alert:@"注册设备成功"];
        MyLog(@"------- 注册设备成功");
    };
    
    void (^errorBlock)(void) = ^(void){
       //[LJAlertView alert:@"注册设备失败"];
        //失败之后的处理
        MyLog(@"------- 注册设备失败");
    };
    NSString * deviceTokenStr = [XGPush registerDevice: deviceToken];
    //注册设备到XG服务端
    [XGPush registerDevice:deviceToken successCallback:successBlock errorCallback:errorBlock];
  //  [LJAlertView alert:[NSString stringWithFormat:@"---- deviceTokenStr:%@",deviceTokenStr]];
    MyLog(@"---- deviceTokenStr:%@",deviceTokenStr);
}
#pragma mark 设备注册失败回调
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
//    [LJAlertView alert:[NSString stringWithFormat:@"Failed to get token, error:%@", error_str]];
}
#pragma mark 接收到通知消息回调
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //应用内接收到推送后 不做处理
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSString * openUrl = nil;
    for (NSString * key in userInfo.allKeys) {
        if ([[key lowercaseString] isEqualToString:@"zixundizhi"] || [[key lowercaseString] isEqualToString:@"openurl"]) {
            openUrl = userInfo[key];
            break;
        }
    }
     MyLog(@"%@",userInfo);
    //应用内接收到推送后 不做处理
    NSDictionary * apsDic = userInfo[@"aps"];
    NSString * alert;
    if (apsDic) {
        alert = apsDic[@"alert"];
    }
    if (!alert) {
        return;
    }
    if (openUrl) {
        //在此处理接收到的消息。
        [LJAlertView showTwoSelectionAlertView:alert?alert:@"" title:@"您收到一条新的推送消息" firstSelectionTitle:@"不去了" secondSelectionTitle:@"去看看" firstSelectionBlock:^{
            
        } secondSelectionBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"receivePushNotification" object:nil userInfo:@{
                                                                                                                     @"openurl":openUrl
                                                                                                                     }];
        }];
    }else{
        [LJAlertView alert:alert?alert:@"" title:@"您收到一条新的推送消息"];
    }
    
}
@end
