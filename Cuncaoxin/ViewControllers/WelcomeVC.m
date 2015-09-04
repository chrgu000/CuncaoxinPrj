//
//  WelcomeVC.m
//  Cuncaoxin
//
//  Created by 刘杰cjs on 15/4/21.
//  Copyright (c) 2015年 com.js.cuncaoxin. All rights reserved.
//

#import "WelcomeVC.h"
#import "PureLayout.h"
#import "MainViewController.h"
#import "AppBaseNavigationController.h"
@interface WelcomeVC ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *ctnView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrv;
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtr;
@end

@implementation WelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_scrv addSubview:_ctnView];
    _scrv.pagingEnabled = YES;
    _scrv.delegate = self;
    _scrv.showsHorizontalScrollIndicator = NO;
    _scrv.bounces= NO;
    [_ctnView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [_ctnView autoSetDimensionsToSize:CGSizeMake(kScreenWidth * 4, kScreenHeight)];
    for (NSInteger i = 1; i<=4; i++) {
        
        NSString * imgname ;
        //640x960
        if (ABS(kScreenHeight/kScreenWidth - 1.5)<=1e-6) {
            imgname = [NSString stringWithFormat:@"welcome_%d_640x960.jpg",i];
        }else{
            imgname = [NSString stringWithFormat:@"welcome_%d_1242x2208.png",i];
        }
        UIImage * img = [UIImage imageNamed:imgname];
        UIImageView * imgv = [[UIImageView alloc]initWithImage:img];
        imgv.frame = CGRectMake((i-1)*kScreenWidth, 0, kScreenWidth, kScreenHeight);
        [_ctnView addSubview:imgv];
        if (i==4) {
            imgv.userInteractionEnabled = YES;
            [imgv addSubview:_startBtn];
            CGFloat w_h_ration = 424.0/114.0;
            CGFloat w = 130;
            _startBtn.layer.cornerRadius = 6;
            _startBtn.layer.borderWidth=1;
            _startBtn.layer.borderColor = kColor(31, 117, 232, 1).CGColor;
            [_startBtn setTitle:@"立即开始" forState:UIControlStateNormal];
            [_startBtn autoSetDimensionsToSize:CGSizeMake(w,w/w_h_ration)];
            [_startBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30];
            [_startBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageCtr.currentPage = scrollView.contentOffset.x / kScreenWidth;
}
- (IBAction)onclickStartBtn:(id)sender {
    NSString * openUrl;
    if (_launchOptions) {
        NSDictionary * remoteDic = _launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        NSString * openUrl = nil;
        if (remoteDic) {
            for (NSString * key in remoteDic.allKeys) {
                if ([[key lowercaseString] isEqualToString:@"zixundizhi"] || [[key lowercaseString] isEqualToString:@"openurl"]) {
                    openUrl = remoteDic[key];
                    break;
                }
            }
        }
    }
    MainViewController * mainVC = [[MainViewController alloc]init];
    mainVC.needAnimation = NO;
    if (openUrl) {
        mainVC.remoteSpecifiedUrl = openUrl;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    AppBaseNavigationController * nav = [[AppBaseNavigationController alloc]initWithRootViewController:mainVC];
    nav.navigationBar.barTintColor = kColor(192, 26, 19, 1);
    nav.navigationBar.tintColor = [UIColor whiteColor];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}
@end
    