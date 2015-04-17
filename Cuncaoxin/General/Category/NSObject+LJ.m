//
//  NSObject+LJ.m
//  反射
//
//  Created by qianfeng on 14-6-11.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import "NSObject+LJ.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>
@implementation NSObject (LJ)
#pragma mark 私有方法,用于获取对象的属性列表
- (NSArray * )getPropertyNames{
    NSMutableArray * propertyNames=[[NSMutableArray alloc]init];
    u_int  outCount;
    objc_property_t * pros=class_copyPropertyList([self class], &outCount);
    for (u_int i=0; i<outCount; i++) {
        NSString * proname= [NSString stringWithUTF8String:property_getName(pros[i])];
        [propertyNames addObject:proname];
    }
    free(pros);
    return propertyNames;
}
//判断对象是否是空
+ (BOOL) objIsNull:(id)obj{
    if (!obj||obj==[NSNull null]) {
        return YES;
    }
    return NO;
}
- (NSString *) toJSONStringWithOutFields:(NSArray *)fields{
    NSMutableDictionary * dic;
    if ([self isKindOfClass:[NSDictionary class]]) {
        dic = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)self];
    }else{
        dic = [NSMutableDictionary dictionaryWithDictionary:[self keyValues]];
    }
    for (NSString * field in fields) {
        [dic removeObjectForKey:field];
    }
    NSData * data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
- (NSString *) toJSONString{
    NSDictionary * dic ;
    if ([self isKindOfClass:[NSDictionary class]]) {
        dic = (NSDictionary *)self;
    }else{
        dic = [self keyValues];
    }
    NSData * data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
- (NSString *) toJSONStringPrettyPrinted{
    NSDictionary * dic ;
    if ([self isKindOfClass:[NSDictionary class]]) {
        dic = (NSDictionary *)self;
    }else{
        dic = [self keyValues];
    }
    NSData * data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end
