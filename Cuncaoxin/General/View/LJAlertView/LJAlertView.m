//
//  LJAlertView.m
//  faew
//
//  Created by jerry on 14-8-14.
//  Copyright (c) 2014年 jerry. All rights reserved.
//
#define kStringIsEmpty(str) ((NSNull *)str ==[NSNull null] || str.length<=0 || !str)
#define kArrayIsEmpty(arr) ((NSNull *)arr ==[NSNull null] || arr.count<=0 || !arr)
#import "LJAlertView.h"
#import <objc/runtime.h>
static void (^_completionBlock)();
static void (^_btn1ClickBlock)();
static void (^_btn2ClickBlock)();
@implementation LJAlertView
#pragma mark ------------------------------------------------------ alert ------------------------------------------------------
+ (void) alert:(NSString * )message{
    [LJAlertView showAlertViewWithParam:@{
                                          kLJAlertViewParamKeyTitle:@"提示",
                                          kLJAlertViewParamKeyMessage:message,
                                          kLJAlertViewParamKeyButtonTitles:@[@"确定"]
                                          }];
}
+ (void)alert:(NSString *)message title:(NSString *)title{
    [LJAlertView showAlertViewWithParam:@{
                                          kLJAlertViewParamKeyTitle:title,
                                          kLJAlertViewParamKeyMessage:message,
                                          kLJAlertViewParamKeyButtonTitles:@[@"确定"],
                                          }];
}
+ (void) alert:(NSString *)message completion:(void (^) ())completionBlock{
    LJAlertViewButtonClickCallBackBlock b = ^ (NSInteger buttonIndex){
        if (completionBlock) {
            completionBlock();
        }
    };
    [LJAlertView showAlertViewWithParam:@{
                                          kLJAlertViewParamKeyTitle:@"提示",
                                          kLJAlertViewParamKeyMessage:message,
                                          kLJAlertViewParamKeyButtonTitles:@[@"确定"],
                                          kLJAlertViewParamKeyButtonCallbackBlocks:@[b]
                                          }];
}
+ (void) alert:(NSString *)message title:(NSString *)title completion:(void (^) ())completionBlock{
    LJAlertViewButtonClickCallBackBlock b = ^ (NSInteger buttonIndex){
        if (completionBlock) {
            completionBlock();
        }
    };
    [LJAlertView showAlertViewWithParam:@{
                                          kLJAlertViewParamKeyTitle:title,
                                          kLJAlertViewParamKeyMessage:message,
                                          kLJAlertViewParamKeyButtonTitles:@[@"确定"],
                                          kLJAlertViewParamKeyButtonCallbackBlocks:@[b],
                                          }];
}
#pragma mark ------------------------------------------------------ confirm ------------------------------------------------------
+ (void) confirm:(NSString *)message confirmBlock:(void (^) ())confirmBlock cancelBlock:(void (^) ())cancelBlock{
    LJAlertViewButtonClickCallBackBlock confirmBck = ^ (NSInteger buttonIndex){
        if (confirmBlock) {
            confirmBlock();
        }
    };
    LJAlertViewButtonClickCallBackBlock cancelBck = ^ (NSInteger buttonIndex){
        if (cancelBlock) {
            cancelBlock();
        }
    };
    [LJAlertView showAlertViewWithParam:@{
                                          kLJAlertViewParamKeyTitle:@"提示",
                                          kLJAlertViewParamKeyMessage:message,
                                          kLJAlertViewParamKeyButtonTitles:@[@"确定",@"取消"],
                                          kLJAlertViewParamKeyButtonCallbackBlocks:@[confirmBck,cancelBck]
                                          }];
}
+ (void) confirm:(NSString *)message title:(NSString *)title confirmBlock:(void (^) ())confirmBlock cancelBlock:(void (^) ())cancelBlock{
    LJAlertViewButtonClickCallBackBlock confirmBck = ^ (NSInteger buttonIndex){
        if (confirmBlock) {
            confirmBlock();
        }
    };
    LJAlertViewButtonClickCallBackBlock cancelBck = ^ (NSInteger buttonIndex){
        if (cancelBlock) {
            cancelBlock();
        }
    };
    [LJAlertView showAlertViewWithParam:@{
                                          kLJAlertViewParamKeyTitle:title,
                                          kLJAlertViewParamKeyMessage:message,
                                          kLJAlertViewParamKeyButtonTitles:@[@"确定",@"取消"],
                                          kLJAlertViewParamKeyButtonCallbackBlocks:@[confirmBck,cancelBck]
                                          }];
}
#pragma mark ------------------------------------------------------ 自定义两个按钮提示框 ------------------------------------------------------
+ (void) showTwoSelectionAlertView:(NSString *)message title:(NSString *)title firstSelectionTitle:(NSString *)firstSelectionTitle secondSelectionTitle:(NSString *)secondSelectionTitle firstSelectionBlock:(void (^) ())firstSelectionBlock secondSelectionBlock:(void (^) ())secondSelectionBlock{
    LJAlertViewButtonClickCallBackBlock fb = ^ (NSInteger buttonIndex){
        if (firstSelectionBlock) {
            firstSelectionBlock();
        }
    };
    LJAlertViewButtonClickCallBackBlock sb = ^ (NSInteger buttonIndex){
        if (secondSelectionBlock) {
            secondSelectionBlock();
        }
    };
    [LJAlertView showAlertViewWithParam:@{
                                          kLJAlertViewParamKeyTitle:title,
                                          kLJAlertViewParamKeyMessage:message,
                                          kLJAlertViewParamKeyButtonTitles:@[firstSelectionTitle,secondSelectionTitle],
                                          kLJAlertViewParamKeyButtonCallbackBlocks:@[fb,sb]
                                          }];
}
+ (void) showAlertViewWithParam:(NSDictionary *)param{
    NSString * title = [param objectForKey:kLJAlertViewParamKeyTitle];
    if (kStringIsEmpty(title)) {
        title = @"提示";
    }
    NSString * message = [param objectForKey:kLJAlertViewParamKeyMessage];
    if (!message || message.length<=0) {
        message = @"提示";
    }
    NSArray * btnTitles = [param objectForKey:kLJAlertViewParamKeyButtonTitles];
    if (kArrayIsEmpty(btnTitles)) {
        btnTitles = @[
                      @"确定"
                      ];
    }
    UIAlertView * av=[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    for (NSString * btnTitle in btnTitles) {
        [av addButtonWithTitle:btnTitle];
    }
    objc_setAssociatedObject(av,@"alertViewParamObj", param, OBJC_ASSOCIATION_RETAIN);
    [av show];
}
#pragma mark ------------------ 内部方法 ------------------
#pragma mark UIAlertView 代理
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSDictionary * param = objc_getAssociatedObject(alertView, @"alertViewParamObj");
    NSArray * btnCallbackBlocks = [param objectForKey:kLJAlertViewParamKeyButtonCallbackBlocks];
    if (kArrayIsEmpty(btnCallbackBlocks)) {
        return;
    }
    if (buttonIndex >= btnCallbackBlocks.count) {
        return;
    }
    LJAlertViewButtonClickCallBackBlock cbblock = btnCallbackBlocks[buttonIndex];
    cbblock(buttonIndex);
}

@end





































