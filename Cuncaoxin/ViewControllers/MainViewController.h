//
//  MainViewController.h
//  Cuncaoxin
//
//  Created by 刘杰cjs on 15/4/17.
//  Copyright (c) 2015年 com.js.cuncaoxin. All rights reserved.
//

#import "AppBaseViewController.h"

@interface MainViewController : AppBaseViewController
//由远程推送的要打开的地址
//如果该参数存在 则打开主页后 再打开该url
@property (nonatomic,copy) NSString * remoteSpecifiedUrl;

@property (nonatomic,strong) UIImage * animationImage;
@property (nonatomic,assign) BOOL needAnimation;
////指定要打开的url
////如果该参数存在 则在当前页面打开该网址
//@property (nonatomic,copy) NSString * specifiedUrl;
@end
