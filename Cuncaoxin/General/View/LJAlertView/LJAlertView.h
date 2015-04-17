//
//  LJAlertView.h
//  faew
//
//  Created by jerry on 14-8-14.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum LJAlertView_Type{
    kLJAlertViewTypeSimpleAlert,
    kLJAlertViewTypeSimpleConfirm
}LJAlertViewType;

typedef void (^LJAlertViewButtonClickCallBackBlock)(NSInteger buttonIndex) ;

//标题
#define kLJAlertViewParamKeyTitle @"kLJAlertViewParamKeyTitle"
//内容
#define kLJAlertViewParamKeyMessage @"kLJAlertViewParamKeyMessage"
//从左到右按钮的title (数组)
#define kLJAlertViewParamKeyButtonTitles @"kLJAlertViewParamKeyButtonTitles"
//从左到右按钮的点击回调事件 (数组)
#define kLJAlertViewParamKeyButtonCallbackBlocks @"kLJAlertViewParamKeyButtonCallbackBlocks"


@interface LJAlertView : UIAlertView<UIAlertViewDelegate>
#pragma mark ------------------ 选择提示框 -------------------
+ (void) alert: (NSString * )message;
+ (void) alert:(NSString * )message title:(NSString *)title;

+ (void) alert:(NSString *)message completion:(void (^) ())completionBlock;
+ (void) alert:(NSString *)message title:(NSString *)title completion:(void (^) ())completionBlock;

+ (void) confirm:(NSString *)message confirmBlock:(void (^) ())confirmBlock cancelBlock:(void (^) ())cancelBlock;
+ (void) confirm:(NSString *)message title:(NSString *)title confirmBlock:(void (^) ())confirmBlock cancelBlock:(void (^) ())cancelBlock;

+ (void) showTwoSelectionAlertView:(NSString *)message title:(NSString *)title firstSelectionTitle:(NSString *)firstSelectionTitle secondSelectionTitle:(NSString *)secondSelectionTitle firstSelectionBlock:(void (^) ())firstSelectionBlock secondSelectionBlock:(void (^) ())secondSelectionBlock;
    
+ (void) showAlertViewWithParam:(NSDictionary *)param;
@end
