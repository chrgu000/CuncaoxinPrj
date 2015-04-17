//
//  NSAttributedString+LJ.m
//  SinaBlog
//
//  Created by qianfeng on 14-6-18.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import "NSAttributedString+LJ.h"

@implementation NSAttributedString (LJ)
- (CGFloat) getAutoSizeHeightWithWidth:(CGFloat)width{
    CGRect f=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:Nil];
    
    return f.size.height;
}
- (CGSize) getAutoSizeWithWidth:(CGFloat)width{
    CGRect f=[self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:Nil];
    return f.size;
}
- (CGRect) getAutoSizeRectWithWidth:(CGFloat)width{
    CGRect f=[self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:Nil];
    return f;
}

//获取适应文字的宽高
- (CGSize) getSingleLineTextSize{
    CGRect f=[self boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:Nil];
    return f.size;
}
//获取单行文字的长度
- (CGFloat) getSingleLineWidth{
    CGRect f=[self boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:Nil];
    
    return f.size.width;
}
//获取单行文字的高度
- (CGFloat) getSingleLineHeight{
    CGRect f=[self boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:Nil];
    return f.size.height;
}
@end
