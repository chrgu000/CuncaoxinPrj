//
//  AppThirdPartyPlatform.h
//  Cuncaoxin
//
//  Created by 刘杰cjs on 15/5/16.
//  Copyright (c) 2015年 com.js.cuncaoxin. All rights reserved.
//

#ifndef Cuncaoxin_AppThirdPartyPlatform_h
#define Cuncaoxin_AppThirdPartyPlatform_h

#pragma mark ----------------- 信鸽推送 -------------------
//即 ACCESS ID
#define kAPSAppID ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.js.cuncaoxin.Cuncaoxin"]?2200104357:2200107278)
//即 ACCESS KEY
#define kAPSAppKey ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.js.cuncaoxin.Cuncaoxin"]?@"IU2PR64J58NY":@"I22XA7X8UC2C")

#pragma mark ----------------- ShareSDK -------------------
#define kShareSDKAppKey @"75bc7a48d7cc"

#pragma mark ----------------- 腾讯开放平台 -------------------
#define kTencentAppID @"1104644834"
#define kTencentAppKey @"zsG8aT9JvL8MEcY5"

#pragma mark ----------------- 微信开放平台 -------------------
#define kWXAppID @"wx78c35372aa3ecf27"
#define kWXAppSecret @"1a2933ecbeee835f51347dc89bdb55ee"
#endif
