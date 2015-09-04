//
//  AppBaseViewController.m
//  Cuncaoxin
//
//  Created by 刘杰cjs on 15/4/17.
//  Copyright (c) 2015年 com.js.cuncaoxin. All rights reserved.
//

#import "AppBaseViewController.h"

@interface AppBaseViewController ()

@end

@implementation AppBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
}
/*
 供子类重写
 返回指定 navBarBtnType 的图片的size
 */
+ (CGSize) barButtonItemImgSizeForType:(NSInteger)navBarBtnType{
    if (navBarBtnType ==AppNavBarIconTypeBack) {
        return CGSizeMake(13, 20);
    }
    
    return CGSizeMake(20, 20);
}
+ (NSString *) barButtonItemImgNameForType:(NSInteger)navBarBtnType{
    if (navBarBtnType ==AppNavBarIconTypeBack) {
        return @"arrow_left_white_nav";
    }
    return @"";
}
@end
