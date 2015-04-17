//
//  UIButton+LJ.m
//  Estay
//
//  Created by jerry on 14-7-15.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "UIButton+LJ.h"
#import "UIView+LJ.h"
#import "NSString+LJ.h"
@implementation UIButton (LJ)
- (CGFloat) titleLeftMargin{
    return self.titleLabel.x;
}
- (CGFloat) titleRightMargin{
    return self.width-self.titleLabel.maxX;
}
- (CGFloat) titleTopMargin{
    return self.titleLabel.maxY;
}
- (CGFloat) titleBottomMargin{
    return self.height-self.titleLabel.maxY;
}
- (CGFloat) imgLeftMargin{
    return self.imageView.x;
}
- (CGFloat) imgRightMargin{
    return self.width-self.imageView.maxX;
}
- (CGFloat) imgTopMargin{
    return self.imageView.y;
}
- (CGFloat) imgBottomMargin{
    return self.height-self.imageView.maxY;
}
- (void) setTitleLeftMargin:(CGFloat)margin{
    NSString * title=self.titleLabel.text;
    UIFont * titleFont=self.titleLabel.font;
    CGFloat w=[title getSingleLineWidthWithFont:titleFont];
    CGFloat  offset=(self.width-w)/2-margin;
    self.titleEdgeInsets=UIEdgeInsetsMake(self.titleEdgeInsets.top,
                                                  self.titleEdgeInsets.left-offset,
                                                  self.titleEdgeInsets.bottom,
                                                  self.titleEdgeInsets.right+offset);
}
//如果存在img 则此方法会出错
- (void) setTitleRightMargin:(CGFloat)margin{
    NSString * title=self.titleLabel.text;
    UIFont * titleFont=self.titleLabel.font;
    CGFloat w=[title getSingleLineWidthWithFont:titleFont];
    CGFloat  offset=(self.width-w)/2-margin;
   
    self.titleEdgeInsets=UIEdgeInsetsMake(self.titleEdgeInsets.top,
                                          self.titleEdgeInsets.left+offset,
                                          self.titleEdgeInsets.bottom,
                                          self.titleEdgeInsets.right-offset);
}
- (void) setTitleTopMargin:(CGFloat)margin{
    NSString * title=self.titleLabel.text;
    UIFont * titleFont=[UIFont systemFontOfSize:15];
    CGFloat h=[title getSingleLineHeightWithFont:titleFont];
    CGFloat  offset=(self.height-h)/2-margin;
    self.titleEdgeInsets=UIEdgeInsetsMake(self.titleEdgeInsets.top-offset,
                                          self.titleEdgeInsets.left,
                                          self.titleEdgeInsets.bottom+offset,
                                          self.titleEdgeInsets.right);
}
- (void) setTitleBottomMargin:(CGFloat)margin{
    NSString * title=self.titleLabel.text;
    UIFont * titleFont=[UIFont systemFontOfSize:15];
    CGFloat h=[title getSingleLineHeightWithFont:titleFont];
    CGFloat  offset=(self.height-h)/2-margin;
    self.titleEdgeInsets=UIEdgeInsetsMake(self.titleEdgeInsets.top+offset,
                                          self.titleEdgeInsets.left,
                                          self.titleEdgeInsets.bottom-offset,
                                          self.titleEdgeInsets.right);
}
- (void) setImgLeftMargin:(CGFloat)margin{
    CGFloat  offset=self.imageView.x-margin;
    self.imageEdgeInsets=UIEdgeInsetsMake(self.imageEdgeInsets.top,
                                          self.imageEdgeInsets.left-offset,
                                          self.imageEdgeInsets.bottom,
                                          self.imageEdgeInsets.right+offset);
}
- (void) setImgRightMargin:(CGFloat)margin{
    CGFloat  offset=self.width-margin-self.imageView.maxX;
    self.imageEdgeInsets=UIEdgeInsetsMake(self.imageEdgeInsets.top,
                                          self.imageEdgeInsets.left+offset,
                                          self.imageEdgeInsets.bottom,
                                          self.imageEdgeInsets.right-offset);
}
- (void) setImgTopMargin:(CGFloat)margin{
    CGFloat  offset=self.imageView.y-margin;
    self.imageEdgeInsets=UIEdgeInsetsMake(self.imageEdgeInsets.top-offset,
                                          self.imageEdgeInsets.left,
                                          self.imageEdgeInsets.bottom+offset,
                                          self.imageEdgeInsets.right);
}
- (void) setImgBottomMargin:(CGFloat)margin{
    CGFloat  offset=self.height-self.imageView.maxY-margin;
    self.imageEdgeInsets=UIEdgeInsetsMake(self.imageEdgeInsets.top+offset,
                                          self.imageEdgeInsets.left,
                                          self.imageEdgeInsets.bottom-offset,
                                          self.imageEdgeInsets.right);
}

@end
