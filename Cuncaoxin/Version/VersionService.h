//
//  VersionService.h
//  Estay
//
//  Created by jerry on 14-8-29.
//  Copyright (c) 2014年 estay. All rights reserved.
//

@class VersionModel;
@interface VersionService : NSObject
#pragma mark 请求获取版本信息
/*
 从 Bmob 云服务平台
 主页地址：http://www.bmob.cn/
 */
+ (void) request_versionInfoSucc:(void (^)(VersionModel * versionModel)) succBlock fail:(void (^)(NSError * error))failBlock;
@end
