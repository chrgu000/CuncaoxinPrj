//
//  NSDictionary+LJ.m
//  Estay
//
//  Created by jerry on 14-7-30.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "NSDictionary+LJ.h"

@implementation NSDictionary (LJ)
- (NSDictionary *)reverseKeyObject{
    NSArray * allKeys=self.allKeys;
    NSArray * allValues=self.allValues;
    NSDictionary * reverseDic=[NSDictionary dictionaryWithObjects:allKeys forKeys:allValues];
    return reverseDic;
}

- (NSMutableDictionary *) dictionaryWithOutNullValue{
    NSMutableDictionary * mdic=[[NSMutableDictionary alloc]initWithDictionary:self];
    NSArray * allKeys=mdic.allKeys;
    for (NSString * key in allKeys) {
        if (mdic[key]==[NSNull null]) {
            [mdic removeObjectForKey:key];
        }
    }
    return mdic;
}
@end
