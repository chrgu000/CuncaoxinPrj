//
//  UIApplication+LJ.m
//  Estay
//
//  Created by jerry on 14-9-27.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "UIApplication+LJ.h"

@implementation UIApplication (LJ)
#pragma mark 判断app是否是第一次打开 或者 是更新后的第一次打开
+ (BOOL) isFirstOpenOrFirstOpenAfterUpdated{
    //从plist中取出版本号
    NSString * versionFromPlist=[NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleVersionKey];
    //从沙盒取出自己设置的版本号
    NSString * versionFromBundle= [[NSUserDefaults standardUserDefaults] objectForKey:(NSString *)kCFBundleVersionKey];
    //如果是第一次打开或者是新版本的第一次打开
    if (versionFromBundle==nil||![versionFromPlist isEqualToString:versionFromBundle]) {
        //写入最新版本号
        [[NSUserDefaults standardUserDefaults] setObject:versionFromPlist forKey:(NSString *)kCFBundleVersionKey];
        //立即写入
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}

@end
