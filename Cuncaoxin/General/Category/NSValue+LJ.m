//
//  NSValue+LJ.m
//  Estay
//
//  Created by jerry on 14-7-31.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "NSValue+LJ.h"

@implementation NSValue (LJ)
+ (NSInteger) securityIntegerValue:(id)obj{
    if (!obj||obj==[NSNull null]) {
        return 0;
    }
    return [obj integerValue];
}
+ (long) securityLongValue:(id)obj{
    if (!obj||obj==[NSNull null]) {
        return 0;
    }
    return [obj longValue];
}
+ (CGFloat) securityCGFloatValue:(id)obj{
    if (!obj||obj==[NSNull null]) {
        return 0;
    }
    return [obj floatValue];
}
+ (BOOL) securityBoolValue:(id)obj{
    if (!obj||obj==[NSNull null]) {
        return NO;
    }
    return [obj boolValue];
}
+ (double) maxNumInNums:(NSArray * ) nums{
    if ((NSNull *)nums==[NSNull null]||nums==nil||nums.count<=0) {
        return CGFLOAT_MAX;
    }
    double max=CGFLOAT_MIN;
    for (NSNumber * numObj in nums) {
        double num=[numObj doubleValue];
        if (num>max) {
            max=num;
        }
    }
    return max;
}
@end
