//
//  UIImage+LJ.m
//  SinaBlog
//
//  Created by qianfeng on 14-6-6.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import "UIImage+LJ.h"
@implementation UIImage (LJ)
#pragma mark 返回将中心进行拉伸的图片
- (UIImage * )resizableImage{
   CGSize size=self.size;
  return [self resizableImageWithCapInsets:UIEdgeInsetsMake(size.height/2-1,size.width/2-1,size.height/2-1,size.width/2-1) resizingMode:UIImageResizingModeStretch];
}
+ (UIImage * )resizableImageWithNamed:(NSString *)name{
    UIImage * img=[UIImage imageNamed:name];
    return [img resizableImage];
}
+ (UIImage * )resizableImageWithNamed:(NSString *)name withCapInsets:(UIEdgeInsets)edgeinsets{
    UIImage * img=[UIImage imageNamed:name];
    return [img resizableImageWithCapInsets:edgeinsets resizingMode:UIImageResizingModeStretch];
}
+ (UIImage * )resizableImageWithNamed:(NSString *)name withCapInsets:(UIEdgeInsets)edgeinsets resizingMode:(UIImageResizingMode)resizingMode{
    UIImage * img=[UIImage imageNamed:name];
    return [img resizableImageWithCapInsets:edgeinsets resizingMode:resizingMode];
}
//调整图片大小
- (UIImage*)imageWithScaleToSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
     UIGraphicsBeginImageContextWithOptions(size,NO,[UIScreen mainScreen].scale);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
//调整图片大小
- (UIImage*)scaleToSize:(CGSize)size
{
    //NEED_YOUHUA_LOG(@"图片代码缩放了");
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(size,NO,[UIScreen mainScreen].scale);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
