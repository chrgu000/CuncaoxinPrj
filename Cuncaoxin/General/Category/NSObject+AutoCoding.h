//
//  NSObject+AutoCoding.h
//  RunTimeTest
//
//  Created by jerry on 14-11-10.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AutoCoding)<NSCoding>
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;
@end
