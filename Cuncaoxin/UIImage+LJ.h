//
//  UIImage+LJ.h
//  SinaBlog
//
//  Created by qianfeng on 14-6-6.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImage (LJ)
//调整图片大小 返回将中心进行拉伸的图片
- (UIImage * )resizableImage;
//调整图片大小 返回将中心进行拉伸的图片
+ (UIImage * )resizableImageWithNamed:(NSString *)name;
+ (UIImage * )resizableImageWithNamed:(NSString *)name withCapInsets:(UIEdgeInsets)edgeinsets;
+ (UIImage * )resizableImageWithNamed:(NSString *)name withCapInsets:(UIEdgeInsets)edgeinsets resizingMode:(UIImageResizingMode)resizingMode;
//调整图片大小
- (UIImage*)imageWithScaleToSize:(CGSize)size;



- (UIImage*)scaleToSize:(CGSize)size __deprecated_msg("使用 imageWithScaleToSize 替代");


@end
