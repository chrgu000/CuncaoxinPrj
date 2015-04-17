//
//  NSDictionary+LJ.h
//  Estay
//
//  Created by jerry on 14-7-30.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LJ)
#pragma mark 将 dictionary 的key 和 object 反转
- (NSDictionary *)reverseKeyObject;

#pragma mark 去除所有值为 [NSNull null]的键值对
- (NSMutableDictionary *) dictionaryWithOutNullValue;

@end
