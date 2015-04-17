//
//  NSData+LJ.m
//  SinaBlog
//
//  Created by qianfeng on 14-6-11.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import "NSData+LJ.h"

@implementation NSData (LJ)
- (id)jsonObject{
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:nil];
}
@end
