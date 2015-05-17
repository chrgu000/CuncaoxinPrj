//
//  MainViewController.m
//  Cuncaoxin
//
//  Created by 刘杰cjs on 15/4/17.
//  Copyright (c) 2015年 com.js.cuncaoxin. All rights reserved.
//

#import "MainViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "VersionService.h"
#import "VersionModel.h"
#import <ShareSDK/ShareSDK.h>
#import "NSString+LJ.h"
@interface MainViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation MainViewController
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePushNotification:) name:@"receivePushNotification" object:nil];
    _animationImage =[UIImage imageNamed:@"launch_640x960"];
    if ((kScreenWidth-320.0)<1e-6 && (kScreenHeight - 480.0)<1e-6) {
        _animationImage =[UIImage imageNamed:@"launch_640x960"];
    }else if ((kScreenWidth-320.0)<1e-6 && (kScreenHeight - 568.0)<1e-6) {
        _animationImage =[UIImage imageNamed:@"launch_640x1136"];
    }else if ((kScreenWidth-375.0)<1e-6 && (kScreenHeight - 667.0)<1e-6) {
        _animationImage =[UIImage imageNamed:@"launch_750x1334"];
    }else if ((kScreenWidth-414.0)<1e-6 && (kScreenHeight - 736.0)<1e-6) {
        _animationImage =[UIImage imageNamed:@"launch_1242x2208"];
    }
    if (_needAnimation) {
        //动画
        UIImageView * animationImgv = [[UIImageView alloc]initWithImage:_animationImage];
        animationImgv.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self.navigationController.view addSubview:animationImgv];
        [UIView animateWithDuration:1.5 animations:^{
            animationImgv.transform = CGAffineTransformMakeScale(1.3, 1.3);
            animationImgv.alpha = 0;
        } completion:^(BOOL finished) {
            [animationImgv removeFromSuperview];
        }];
    }
    
    
    [VersionService request_versionInfoSucc:^(VersionModel *versionModel) {
        if (!versionModel.isActive) {
            return ;
        }
        //如果有新版本
        if (versionModel && [NSString compareVersion:kAppVersion toVersion:versionModel.versionNo]==NSOrderedAscending) {
            MyLog(@"新版本地址：%@",versionModel.installationPackageDownloadAddress);
            NSString * appDownUrl=versionModel.installationPackageDownloadAddress;
            BOOL isForceUpdate=versionModel.isForceUpdate;
            NSString * versionDecs=versionModel.versionDescription;
            NSArray * deses= [versionDecs componentsSeparatedByString:@"#"];
            //新版本描述数组
            NSMutableString * formatVersionDes=[[NSMutableString alloc]init];
            for (NSInteger i = 0;i<deses.count;i++) {
                [formatVersionDes appendFormat:@"%ld.%@\n",i+1,(NSString *)deses[i]];
            }
            if (isForceUpdate) {
                void (^completionBlock)() = ^void() {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appDownUrl]];
                };
                [LJAlertView showAlertViewWithParam:@{
                                                      kLJAlertViewParamKeyTitle:formatVersionDes,
                                                      kLJAlertViewParamKeyMessage:[NSString stringWithFormat:@"发现新版本 (%@)",versionModel.versionNo],
                                                      kLJAlertViewParamKeyButtonTitles:@[@"立即下载"],
                                                      kLJAlertViewParamKeyButtonCallbackBlocks:@[completionBlock]
                                                      }];
            }else{
                [LJAlertView showTwoSelectionAlertView:formatVersionDes title:[NSString stringWithFormat:@"发现新版本 (%@)",versionModel.versionNo] firstSelectionTitle:@"以后再说" secondSelectionTitle:@"立即下载" firstSelectionBlock:^{
                    MyLog(@"以后再说");
                } secondSelectionBlock:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appDownUrl]];
                }];
            }
        }else{
            MyLog(@"无版本更新");
        }
    } fail:^(NSError *error) {
        
    }];
    self.navigationBarTitle = @"江苏寸草心教育";
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webview.delegate=_progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth, 2)];
    [self.view addSubview:_progressView];

    if (_remoteSpecifiedUrl) {
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_remoteSpecifiedUrl]]];
        
    }else{
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.lkwzs.com/index.php?token=tqgcob1426137232&g=Wap&a=index&m=Index"]]];
    }
    self.leftNavigationBarButtonType = AppNavBarIconTypeBack;
}
- (void)onClickNavgationBarLeftBtn:(UIButton *)btn withNavigationBarBtnType:(NSInteger)navigationBarBtnType{
    //说明此时 是远程推送的url正在显示在第一页
    if (_remoteSpecifiedUrl && ![_webview canGoBack]) {
        
        _remoteSpecifiedUrl = nil;
        [_webview removeFromSuperview];
        _webview = nil;
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 2, kScreenWidth, kScreenHeight-62)];
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.lkwzs.com/index.php?token=tqgcob1426137232&g=Wap&a=index&m=Index"]]];
        _webview.delegate =_progressProxy;
        [self.view addSubview:_webview];
        
    }else{
        if ([_webview canGoBack]) {
            [_webview goBack];
        }
    }
    
}
- (void)receivePushNotification:(NSNotification *)notification{
   NSDictionary * userInfo = notification.userInfo;
    NSString * openurl = userInfo[@"openurl"];
    if (openurl) {
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:openurl]]];
    }
}
#pragma mark 点击分享
- (IBAction)onclickShare:(id)sender {
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"专业的教育信息提供平台"
                                       defaultContent:@"专业的教育信息提供平台"
                                                image:[ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"icon_512" ofType:@"png"]]
                                                title:@"寸草心教育"
                                                  url:@"https://itunes.apple.com/us/app/cun-cao-xin-jiao-yu/id990104805"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}
#pragma mark ------------------------------------------ NJKWebViewProgressDelegate 代理
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    MyLog(@"webViewD didFailLoadWithError:%@",error);
}

@end
