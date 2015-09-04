//
//  VersionService.m
//  Estay
//
//  Created by jerry on 14-8-29.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "VersionService.h"
#import "VersionModel.h"
#import "NSObject+LJ.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "Common.h"
#import "NSString+LJ.h"
/*
   有两个 渠道ID （ChannelID） AppStore、DistributionOwn（企业账号打包的自纷发渠道）
 
 */
@implementation VersionService
#pragma mark 请求获取版本信息 (有缓存，缓存生命周期：整个应用)
+ (void) request_versionInfoSucc:(void (^)(VersionModel * versionModel)) succBlock fail:(void (^)(NSError * error))failBlock{
    NSString * bundleID = [NSBundle mainBundle].bundleIdentifier;
    NSString * channelID;
    if ([bundleID isEqualToString:@"com.js.cuncaoxin.Cuncaoxin"]) {
        channelID = @"AppStore";
    }else{
        channelID = @"DistributionOwn";
    }
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    NSDictionary * searchCondition = @{
                                       @"channelID":channelID
                                       };
    NSDictionary * params = @{
                              @"where":[searchCondition toJSONString]
                              };
    NSError * tmpError;
    NSMutableURLRequest * req= [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"https://api.bmob.cn/1/classes/versionForIOS" parameters:params error:&tmpError];
    [req setValue:@"c47e3a44436a854989018d8015c739ac" forHTTPHeaderField:@"X-Bmob-Application-Id"];
    [req setValue:@"6850877e1228135048ec4c67dea063f8" forHTTPHeaderField:@"X-Bmob-REST-API-Key"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    AFHTTPRequestOperation * requestOperation=  [manager HTTPRequestOperationWithRequest:req success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"获取版本信息请求响应-%@",operation.responseString);
        NSDictionary * rspDic = [operation.responseString jsonObject];
        NSArray * rsArr = (NSArray *)rspDic[@"results"];
        if (rsArr.count>0) {
            NSDictionary * versionInfoDic = ((NSArray *)rspDic[@"results"])[0];
            VersionModel * vm = [VersionModel objectWithKeyValues:versionInfoDic];
            succBlock(vm);
        }else{
            MyLog(@"获取版本信息请求失败:没有版本信息");
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"error:%@",error);
        failBlock(error);
    }];
    [requestOperation start];
}
@end
