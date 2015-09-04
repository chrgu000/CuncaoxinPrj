//
//  UserInfoModel.h
//  Estay
//
//  Created by jerry on 14-7-31.
//  Copyright (c) 2014年 estay. All rights reserved.
//
@interface VersionModel : NSObject
    @property (nonatomic,copy) NSString * channelID;//渠道ID
    @property (nonatomic,copy) NSString * channelName;//渠道名称
    @property (nonatomic,copy) NSString * versionNo;//版本号
    @property (nonatomic,copy) NSString * versionDescription;//版本描述
    @property (nonatomic,copy) NSString * installationPackageDownloadAddress;//更新文件地址
    @property (nonatomic,assign) BOOL isForceUpdate;//是否强制更新
    @property (nonatomic,assign) BOOL isActive;//是否生效
@end
