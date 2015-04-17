//
//  NSObject+AutoCoding.m
//  RunTimeTest
//
//  Created by LJ on 14-11-10.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "NSObject+AutoCoding.h"
#include <objc/runtime.h>
@implementation NSObject (AutoCoding)
- (NSArray *) propertyNames{
    Class subclass=[self class];
    NSMutableArray *array = [NSMutableArray array];
    //从当前类遍历到顶级父类 除了NSObject
    while (subclass!=[NSObject class]) {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList([subclass class],&propertyCount);
        for (int i = 0; i < propertyCount; i++){
            objc_property_t property = properties[i];
            NSString *propertyName = @(property_getName(property));
            char *ivar = property_copyAttributeValue(property, "V");
            if (ivar)
            {
                NSString *ivarName = @(ivar);
                /*
                  假如有个属性不想编码。
                 例如，.h文件中 定义了 @property (nonatomic,assign) int a;
                 则.m文件中 定义 @synthesize a=_a_NOENCODE;（原本属性对应的ivar name 加上 _NOENCODE即可）则该属性不参与编码。
                 下面代码则是该功能的实现
                 */
                if (![ivarName isEqualToString:[NSString stringWithFormat:@"_%@_NOENCODE",propertyName]])
                {
                    [array addObject:propertyName];
                }
                free(ivar);
            }
        }
        free(properties);
        subclass=[subclass superclass];
    }
    return array;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    NSArray * propertyNames=[self propertyNames];
    for (NSString * proName in propertyNames) {
        //oc 会自动 boxing 和 unboxing 所以此处不用为基本类型调用对应的encodexxx方法
        [aCoder encodeObject:[self valueForKey:proName] forKey:proName];
    }
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    NSArray * propertyNames=[self propertyNames];
    for (NSString * proName in propertyNames) {
        [self setValue:[aDecoder decodeObjectForKey:proName] forKey:proName];
    }
    return self;
}
@end
