//
//  BaseViewController.h
//  Estay
//
//  Created by jerry on 14-7-27.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LJ.h"
#import "LJAlertView.h"
#import "Common.h"

#pragma mark --------------------------------------------------- ProgressHUD 控制器代理 --------------------------------------------------------
//用于负责 ProgressHUD 展示
@protocol GeneralProgressHUDDelegate <NSObject>
    - (void) showProgressHUDOnView:(UIView *)view animated:(BOOL)animated;
    - (void) hideProgressHUDOnView:(UIView *)view animated:(BOOL)animated;
@end

#pragma mark ------------------------------------------------------ 主类 ------------------------------------------------------
//注:子类重写内部方法时，NavBarBtnType类型参数传入 NSInteger 值即可, 此处定义 NavBarBtnType 类型是为方便阅读
@interface LJBaseViewController : UIViewController
    #pragma mark --------------------- @property ProgressHUD 相关
    // ProgressHUD 控制器代理
    //该处用strong 该处使用weak则会立即释放。注意若以后该代理引用了self 请传入self 的 __weak指针(而不是将此处改为weak)
    @property (nonatomic,strong) id<GeneralProgressHUDDelegate>  progressHUDDelegate;
    #pragma mark --------------------- @property UINavigationBar 相关
    @property (nonatomic,assign) NSInteger leftNavigationBarButtonType;
    @property (nonatomic,assign) NSInteger rightNavigationBarButtonType;
    @property (nonatomic,copy) NSString * navigationBarTitle;
    @property (nonatomic,strong) UIColor * navigationBarTitleColor;
    @property (nonatomic,strong) UIFont * navigationBarTitleFont;

    #pragma mark --------------------- ProgressHUD 相关 ---------------------
    //显示 loading hud
    - (void) showProgressHUD;
    //隐藏 loading hud
    - (void) hideProgressHUD;
    //显示 loading hud
    - (void) showProgressHUDOnView:(UIView * )view;
    //显示 loading hud 于指定的view
    - (void) hideProgressHUDOnView:(UIView * )view;

    #pragma mark --------------------- UINavigationBar 相关 ---------------------
    /*
     供子类重写
     返回指定 navBarBtnType 的图片的size
     */
    + (CGSize) barButtonItemImgSizeForType:(NSInteger)navBarBtnType;
    /*
     供子类重写
     返回指定 navBarBtnType 的图片的name
     */
    + (NSString *) barButtonItemImgNameForType:(NSInteger)navBarBtnType;
    /*
     当前类无操作  供子类重写
     处理点击导航栏左侧按钮事件
     */
    - (void)onClickNavgationBarLeftBtn:(UIButton * )btn withNavigationBarBtnType:(NSInteger)navigationBarBtnType;
    /*
     当前类无操作  供子类重写
     处理点击导航栏右侧按钮事件
     */
    - (void)onClickNavgationBarRightBtn:(UIButton * )btn withNavigationBarBtnType:(NSInteger)navigationBarBtnType;
@end