//
//  NSValue+LJ.h
//  Estay
//
//  Created by jerry on 14-7-31.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValue (LJ)
+ (NSInteger) securityIntegerValue:(id)obj;
+ (CGFloat) securityCGFloatValue:(id)obj;
+ (BOOL) securityBoolValue:(id)obj;
+ (double) maxNumInNums:(NSArray * ) nums;
+ (long) securityLongValue:(id)obj;
@end
