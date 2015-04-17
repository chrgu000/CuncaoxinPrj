//
//  UIApplication+LJ.h
//  Estay
//
//  Created by jerry on 14-9-27.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (LJ)
#pragma mark 是否是第一次打开 或者是 更新后的第一次打开
+ (BOOL) isFirstOpenOrFirstOpenAfterUpdated;

@end
