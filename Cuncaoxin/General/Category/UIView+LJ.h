//
//  UIView+LJ.h
//  Estay
//
//  Created by jerry on 14-7-10.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LJ)
@property (nonatomic,assign,readonly) CGFloat maxX;
@property (nonatomic,assign,readonly) CGFloat maxY;
@property (nonatomic,assign,readonly)CGFloat aspectRatio ;//宽高比
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGPoint origin;

#pragma mark 自身属性信息格式化属性
@property (nonatomic,copy,readonly)NSString * frameString;


#pragma mark 在父控件中垂直居中
- (void) verticalCenterInSuperView;
#pragma mark 在父控件中水平居中
- (void) horizenCenterInSuperView;
#pragma mark 在父控件中居中
- (void) centerInSuperView;

#pragma mark 将中心点的Y设置成与指定view的中心点Y坐标相同
- (void) centerYEqualToView:(UIView *)view;
#pragma mark 将中心点的X设置成与指定view的中心点X坐标相同
- (void) centerXEqualToView:(UIView *)view;
#pragma mark 将中心点设置成与指定view的中心点相同
- (void) centerEqualToView:(UIView *)view;

#pragma mark 将底部与指定的view对其
- (void) maxYEqualToView:(UIView *)view;
#pragma mark 将最大 x设置为与指定view相同
- (void) maxXEqualToView:(UIView *)view;
#pragma mark 移除所有子控件
- (void) removeAllSubviews;

#pragma mark 根据宽度 按指定比例设置高度
- (void) scaleHeightByWidth:(CGFloat)width withAspectRatio:(CGFloat)aspectRatio;
#pragma mark 根据高度 按指定比例设置宽度
- (void) scaleWidthByHeight:(CGFloat)height withAspectRatio:(CGFloat)aspectRatio;

#pragma mark 根据宽度 按当前宽高比设置高度
- (void) aspectRatioScaleHeightByWidth:(CGFloat)width;
#pragma mark 根据高度 按当前宽高比设置宽度
- (void) aspectRatioScaleWidthByHeight:(CGFloat)height;

#pragma mark 以UIImage 的形式返回当前view 的快照
- (UIImage * ) snapShotImage;

#pragma mark 将view转成image
- (UIImage * )convertToImg;


#pragma mark frame计算方法
+ (void) setFrame:(CGRect *) sourceFrame CenterYEqualToFrame:(CGRect *)desFrame;
+ (void) setFrame:(CGRect *) sourceFrame CenterXEqualToFrame:(CGRect *)desFrame;
+ (void) setFrame:(CGRect *) sourceFrame MaxYEqualToFrame:(CGRect *)desFrame;
+ (void) setFrame:(CGRect *) sourceFrame MaxXEqualToFrame:(CGRect *)desFrame;


//#warning "临时 临时 临时 临时 临时"
//- (void) addSeparateLineWithFrame:(CGRect)frame color:(UIColor * )color;
//- (void) addSeparateLineWithFrame:(CGRect)frame;

+ (CALayer *) createSeparateLineWithFrame:(CGRect)frame color:(UIColor * )color;
+ (CALayer *) createSeparateLineWithFrame:(CGRect)frame;
@end
