//
//  NSArray+LJ.m
//  Estay
//
//  Created by jerry on 14-11-18.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "NSArray+LJ.h"

@implementation NSArray (LJ)
- (NSArray * )getObjectsExceptObject:(NSObject *)obj{
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF!=%@",obj]];
}
- (NSArray * )getObjectsExceptObjects:(NSArray *)objs{
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"NOT(SELF in %@)",objs]];
}
@end
