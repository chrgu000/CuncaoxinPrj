//
//  LJBaseXibView.h
//  iOSPrototypeProject
//
//  Created by 刘杰cjs on 15/1/15.
//  Copyright (c) 2015年 刘杰cjs. All rights reserved.
//
/*
 当自定义view是使用xib定义的时候 则继承该类
 contentView 表示是xib中的根view
 设置frame相关属性时 设置self即可
 设置其他view属性 则要设置到 contentView 上
 */
#import "UIView+LJ.h"
@interface LJBaseXibView : UIView
@property (strong, nonatomic)  UIView * contentView;
/*
 当xib 文件中有多个自定义view时，此时需要指定一个view 作为当前对象的contentView,这是可以通过设置该属性设置
 如果指定 contentViewTag 不存在  则不修改 当前contentView
 */
//指定XIB文件中的要设置为contentView的view的tag
@property (assign, nonatomic)  NSInteger  contentViewTag;
@end
