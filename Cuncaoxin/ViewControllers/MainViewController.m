//
//  MainViewController.m
//  Cuncaoxin
//
//  Created by 刘杰cjs on 15/4/17.
//  Copyright (c) 2015年 com.js.cuncaoxin. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftNavigationBarButtonType = AppNavBarIconTypeBack;
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.lkwzs.com/index.php?token=tqgcob1426137232&g=Wap&a=index&m=Index"]]];
}

@end
