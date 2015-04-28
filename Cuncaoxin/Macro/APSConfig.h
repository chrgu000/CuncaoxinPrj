//
//  APSConfig.h
//  Cuncaoxin
//
//  Created by 刘杰cjs on 15/4/17.
//  Copyright (c) 2015年 com.js.cuncaoxin. All rights reserved.
//

#ifndef Cuncaoxin_APSConfig_h
#define Cuncaoxin_APSConfig_h

//即 ACCESS ID
#define kAPSAppID ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.js.cuncaoxin.Cuncaoxin"]?2200104357:2200107278)
//即 ACCESS KEY
#define kAPSAppKey ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.js.cuncaoxin.Cuncaoxin"]?@"IU2PR64J58NY":@"I22XA7X8UC2C")
#endif
