//
//  UIView+LJ.m
//  Estay
//
//  Created by jerry on 14-7-10.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "UIView+LJ.h"
#import "Common.h"
@implementation UIView (LJ)
#pragma mark 将view设置为在父控件中垂直居中
- (void) verticalCenterInSuperView{
    UIView * superView = self.superview;
    self.y =(superView.height - self.height)/2;
}
#pragma mark 将view设置为在父控件中水平居中
- (void) horizenCenterInSuperView{
    UIView * superView = self.superview;
    self.x =(superView.width - self.width)/2;
}
#pragma mark 在父控件中居中
- (void) centerInSuperView{
    CGPoint selfCenter= self.center;
    UIView * superView = self.superview;
    CGFloat centerX=superView.frame.size.width/2;
    CGFloat centerY=superView.frame.size.height/2;
    selfCenter = CGPointMake(centerX, centerY);
}

#pragma mark 将view中心y设置为与指定view相同
- (void) centerYEqualToView:(UIView *)view{
    CGPoint selfCenter=self.center;
    selfCenter.y=view.center.y;
    self.center=selfCenter;
}
#pragma mark 将view中心x设置为与指定view相同
- (void) centerXEqualToView:(UIView *)view{
    CGPoint selfCenter=self.center;
    selfCenter.x=view.center.x;
    self.center=selfCenter;
}
#pragma mark 将中心点设置成与指定view的中心点相同
- (void) centerEqualToView:(UIView *)view{
    self.center = view.center;
}


#pragma mark 将view 最大Y设置为与指定view相同
- (void) maxYEqualToView:(UIView *)view{
    self.y=view.frame.origin.y-(self.frame.size.height-view.frame.size.height);
}
#pragma mark 将view 最大 x设置为与指定view相同
- (void) maxXEqualToView:(UIView *)view{
    self.x=view.x-(self.width-view.width);
}

#pragma mark 等比例设置高度
- (void) scaleHeightByWidth:(CGFloat)width withAspectRatio:(CGFloat)aspectRatio{
    CGFloat h=width/aspectRatio;
    [self setSize:CGSizeMake(width, h)];
}
#pragma mark 等比例设置宽度
- (void) scaleWidthByHeight:(CGFloat)height withAspectRatio:(CGFloat)aspectRatio{
    CGFloat w=height*aspectRatio;
    [self setSize:CGSizeMake(w, height)];
}
#pragma mark 根据宽度 按当前宽高比设置高度
- (void) aspectRatioScaleHeightByWidth:(CGFloat)width{
    CGFloat h=width/(self.width/self.height);
    [self setSize:CGSizeMake(width, h)];
}
#pragma mark 根据高度 按当前宽高比设置宽度
- (void) aspectRatioScaleWidthByHeight:(CGFloat)height{
    CGFloat w=height*(self.width/self.height);
    [self setSize:CGSizeMake(w, height)];
}

#pragma mark ---getter/setter
- (CGFloat) maxX{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat) maxY{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat) x{
    return self.frame.origin.x;
}
- (CGFloat) y{
    return self.frame.origin.y;
}
- (CGFloat) width{
    return self.frame.size.width;
}
- (CGFloat) height{
    return self.frame.size.height;
}
- (CGPoint) origin{
    return self.frame.origin;
}
- (CGSize) size{
    return self.frame.size;
}
- (void) setX:(CGFloat)x{
    CGRect  f=self.frame;
    f.origin.x=x;
    self.frame=f;
}
- (void) setY:(CGFloat)y{
    CGRect  f=self.frame;
    f.origin.y=y;
    self.frame=f;
}
- (void) setWidth:(CGFloat )width{
    CGRect  f=self.frame;
    f.size.width=width;
    self.frame=f;
}
- (void) setHeight:(CGFloat )height{
    CGRect  f=self.frame;
    f.size.height=height;
    self.frame=f;
}
- (void) setOrigin:(CGPoint)origin{
    CGRect  f=self.frame;
    f.origin=origin;
    self.frame=f;
}
- (void) setSize:(CGSize)size{
    CGRect f=self.frame;
    f.size=size;
    self.frame=f;
}
//移除所有子控件
- (void) removeAllSubviews{
    for (UIView * subv in self.subviews) {
        [subv removeFromSuperview];
    }
}

#pragma mark 获取宽高比
- (CGFloat) aspectRatio{
    return self.frame.size.width/self.frame.size.height;
}


- (UIImage * ) snapShotImage{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    //获取图像
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark ---frame相关操作
+ (void) setFrame:(CGRect *) sourceFrame CenterXEqualToFrame:(CGRect *)desFrame{
    (*sourceFrame).origin.x=(*desFrame).origin.x+((*desFrame).size.width-(*sourceFrame).size.width)/2;
}

+ (void) setFrame:(CGRect *) sourceFrame CenterYEqualToFrame:(CGRect *)desFrame{
    (*sourceFrame).origin.y=(*desFrame).origin.y+((*desFrame).size.height-(*sourceFrame).size.height)/2;
}
+ (void) setFrame:(CGRect *) sourceFrame MaxYEqualToFrame:(CGRect *)desFrame{
    (*sourceFrame).origin.y=(*desFrame).origin.y+((*desFrame).size.height-(*sourceFrame).size.height);
}
+ (void) setFrame:(CGRect *) sourceFrame MaxXEqualToFrame:(CGRect *)desFrame{
    (*sourceFrame).origin.x=(*desFrame).origin.x+((*desFrame).size.width-(*sourceFrame).size.width);
}
#pragma mark 自身属性信息格式化属性
- (NSString *) frameString{
    return NSStringFromCGRect(self.frame);
}



- (void) addSeparateLineWithFrame:(CGRect)frame color:(UIColor * )color{
    CALayer *line = [CALayer layer];
    line.frame = frame;
    line.backgroundColor = color.CGColor;
    [self.layer addSublayer:line];
}
- (void) addSeparateLineWithFrame:(CGRect)frame{
    CALayer *line = [CALayer layer];
    line.frame = frame;
    line.backgroundColor = kColor(208, 208, 208, 1).CGColor;
    [self.layer addSublayer:line];
}
+ (CALayer *) createSeparateLineWithFrame:(CGRect)frame color:(UIColor * )color{
    CALayer *line = [CALayer layer];
    line.frame = frame;
    line.backgroundColor = color.CGColor;
    return line;
}
+ (CALayer *) createSeparateLineWithFrame:(CGRect)frame{
    CALayer *line = [CALayer layer];
    line.frame = frame;
    line.backgroundColor = [UIColor grayColor].CGColor;
    return line;
}
#pragma mark 将view转成image
- (UIImage * )convertToImg{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,NO,[UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
