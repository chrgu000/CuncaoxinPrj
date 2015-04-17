//
//  BaseViewController.m
//  Estay
//
//  Created by jerry on 14-7-27.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "LJBaseViewController.h"

#import "MBProgressHUD.h"

#pragma mark --------------------- 通用的 ProgressHUD 实现 ---------------------
@interface GeneralProgressHUDController:NSObject<GeneralProgressHUDDelegate>
    - (void) showProgressHUDOnView:(UIView *)view animated:(BOOL)animated;
    - (void) hideProgressHUDOnView:(UIView *)view animated:(BOOL)animated;
@end

@implementation GeneralProgressHUDController
    - (void) showProgressHUDOnView:(UIView *)view animated:(BOOL)animated{
        [MBProgressHUD showHUDAddedTo:view animated:animated];
    }
    - (void) hideProgressHUDOnView:(UIView *)view animated:(BOOL)animated{
        [MBProgressHUD hideHUDForView:view animated:animated];
    }
@end


#pragma mark ------------------------------------------------------------------ 主类 ------------------------------------------------------------------
@implementation LJBaseViewController
    - (void)viewDidLoad
    {
        [super viewDidLoad];
        _progressHUDDelegate = [[GeneralProgressHUDController alloc]init];
    }
    #pragma mark ------------------------------------------ ProgressHUD 相关 ------------------------------------------
    //showProgressHUD 和 hideProgressHUD 成对使用
    //显示 loading hud 默认添加在 self.view 上
    - (void) showProgressHUD{
        [_progressHUDDelegate showProgressHUDOnView:self.view animated:YES];
    }
    //隐藏 loading hud 默认添加在 self.view 上
    - (void) hideProgressHUD{
        [_progressHUDDelegate hideProgressHUDOnView:self.view animated:YES];
    }
    //显示 loading hud 于指定的view
    - (void) showProgressHUDOnView:(UIView * )view{
        [_progressHUDDelegate showProgressHUDOnView:view animated:YES];
    }
    //显示 loading hud 于指定的view
    - (void) hideProgressHUDOnView:(UIView * )view{
        [_progressHUDDelegate hideProgressHUDOnView:view animated:YES];
    }
    #pragma mark ------------------------------------------ UINavigationBar 相关 ------------------------------------------
    - (void)setNavigationBarTitle:(NSString *)navigationBarTitle{
        if (!self.navigationController) {
            return;
        }
        _navigationBarTitle = navigationBarTitle;
        UILabel * titleLb;
        if (self.navigationItem.titleView) {
            titleLb= (UILabel *)self.navigationItem.titleView;
        }else{
            titleLb = [self createNavTitleLabel];
        }
        titleLb.text=navigationBarTitle;
        [titleLb sizeToFit];
        self.navigationItem.titleView = titleLb;
    }
    - (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor{
        if (!self.navigationController) {
            return;
        }
        _navigationBarTitleColor = navigationBarTitleColor;
        UILabel * titleLb;
        if (self.navigationItem.titleView) {
            titleLb= (UILabel *)self.navigationItem.titleView;
        }else{
            titleLb = [self createNavTitleLabel];
        }
        titleLb.textColor=navigationBarTitleColor;
        self.navigationItem.titleView = titleLb;
    }
    - (void)setNavigationBarTitleFont:(UIFont *)navigationBarTitleFont{
        if (!self.navigationController) {
            return;
        }
        _navigationBarTitleFont = navigationBarTitleFont;
        UILabel * titleLb;
        if (self.navigationItem.titleView) {
            titleLb= (UILabel *)self.navigationItem.titleView;
        }else{
            titleLb = [self createNavTitleLabel];
        }
        titleLb.font=navigationBarTitleFont;
        self.navigationItem.titleView = titleLb;
    }

    - (UILabel * )createNavTitleLabel{
        UILabel * titleLb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, -1,-1)];
        titleLb.textAlignment=NSTextAlignmentCenter;
        titleLb.textColor=_navigationBarTitleColor;
        [titleLb sizeToFit];
        return titleLb;
    }
    - (void)setLeftNavigationBarButtonType:(NSInteger)leftNavigationBarButtonType{
        if (!self.navigationController) {
            return;
        }
        self.navigationItem.leftBarButtonItem = [self createBarBtnItemForNavBarBtnType:leftNavigationBarButtonType isLeft:YES];
    }
    - (void)setRightNavigationBarButtonType:(NSInteger)rightNavigationBarButtonType{
        if (!self.navigationController) {
            return;
        }
        self.navigationItem.rightBarButtonItem = [self createBarBtnItemForNavBarBtnType:rightNavigationBarButtonType isLeft:NO];
    }

    //根据 NSInteger 创建 UIBarButtonItem
    //isLeft:是否是导航栏左边的按钮
    - (UIBarButtonItem * ) createBarBtnItemForNavBarBtnType:(NSInteger)barBtnType isLeft:(BOOL)isLeft{
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        CGSize btnSize = [[self class] barButtonItemImgSizeForType:barBtnType];
        NSString * btnImgName =[[self class] barButtonItemImgNameForType:barBtnType];
        btn.frame=CGRectMake(0, 0,btnSize.width,btnSize.height);
        [btn setImage:[UIImage imageNamed:btnImgName] forState:UIControlStateNormal];
        btn.tag=barBtnType;
        SEL onClickNavHandler = isLeft?@selector(onClickNavgationBarLeftBtn:):@selector(onClickNavgationBarRightBtn:);
        [btn addTarget:self action:onClickNavHandler forControlEvents:UIControlEventTouchUpInside];
        return [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    //点击 导航栏左侧 按钮
    - (void)onClickNavgationBarLeftBtn:(UIButton * )btn{
        //收集参数，调用对外接口 将点击事件传递
        [self onClickNavgationBarLeftBtn:btn withNavigationBarBtnType:btn.tag];
    }
    //点击 导航栏右侧 按钮
    - (void)onClickNavgationBarRightBtn:(UIButton *)btn{
        //收集参数，调用对外接口 将点击事件传递
        [self onClickNavgationBarRightBtn:btn withNavigationBarBtnType:btn.tag];
    }
    #pragma mark ------------ 外部接口
    //当前类返回0  需要子类重写
    + (CGSize) barButtonItemImgSizeForType:(NSInteger)NSInteger{
        return CGSizeZero;
    }
    //当前类返回nil  需要子类重写
    + (NSString *) barButtonItemImgNameForType:(NSInteger)NSInteger{
        return nil;
    }
    //子类覆盖 点击导航栏左侧 按钮
    - (void)onClickNavgationBarLeftBtn:(UIButton * )btn withNavigationBarBtnType:(NSInteger)navigationBarBtnType{
        
    }
    //子类覆盖 点击导航栏右侧 按钮
    - (void)onClickNavgationBarRightBtn:(UIButton * )btn withNavigationBarBtnType:(NSInteger)navigationBarBtnType{
        
    }
@end
