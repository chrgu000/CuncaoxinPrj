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
#import "APSConfig.h"
#import "XGSetting.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //基础业务配置
    [self basicServiceConfiguration:launchOptions];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainViewController * mainVC = [[MainViewController alloc]init];
    AppBaseNavigationController * nav = [[AppBaseNavigationController alloc]initWithRootViewController:mainVC];
    self.window.rootViewController = nav;
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
    [LJAlertView alert:[NSString stringWithFormat:@"Failed to get token, error:%@", error_str]];
}
#pragma mark 接收到通知消息回调
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //在此处理接收到的消息。
    [LJAlertView alert:[NSString stringWithFormat:@"接收到的消息:%@", userInfo]];
}
@end
