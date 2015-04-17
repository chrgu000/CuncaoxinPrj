//
//  NSAttributedString+LJ.h
//  SinaBlog
//
//  Created by qianfeng on 14-6-18.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (LJ)
- (CGFloat) getAutoSizeHeightWithWidth:(CGFloat)width;
- (CGSize)  getAutoSizeWithWidth:(CGFloat)width;
- (CGRect)  getAutoSizeRectWithWidth:(CGFloat)width;

//获取单行适应文字的宽高
- (CGSize) getSingleLineTextSize;
//获取单行文字的长度
- (CGFloat) getSingleLineWidth;
//获取单行文字的高度
- (CGFloat) getSingleLineHeight;
@end
