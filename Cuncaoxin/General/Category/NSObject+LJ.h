//
//  NSObject+LJ.h
//  反射
//
//  Created by qianfeng on 14-6-11.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface NSObject (LJ)
#pragma mark 私有方法,用于获取对象的属性列表
- (NSArray * )getPropertyNames;
- (NSString *) toJSONStringWithOutFields:(NSArray *)fields;
- (NSString *) toJSONString;
- (NSString *) toJSONStringPrettyPrinted;
#pragma mark 判断对象是否是空
+ (BOOL) objIsNull:(id)obj;
@end
