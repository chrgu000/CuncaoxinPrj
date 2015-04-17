//
//  NSArray+LJ.h
//  Estay
//
//  Created by jerry on 14-11-18.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LJ)
#pragma mark 获取除了指定元素以外的所有元素
- (NSArray * )getObjectsExceptObject:(NSObject *)obj;
#pragma mark 获取除了指定元素集合以外的所有元素
- (NSArray * )getObjectsExceptObjects:(NSArray *)objs;
@end
