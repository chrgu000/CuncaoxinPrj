//
//  LJBaseXibView.m
//  iOSPrototypeProject
//
//  Created by 刘杰cjs on 15/1/15.
//  Copyright (c) 2015年 刘杰cjs. All rights reserved.
//

#import "LJBaseXibView.h"
#import "PureLayout.h"
@implementation LJBaseXibView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self internalInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self internalInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self internalInit];
    }
    return self;
}
- (void) internalInit{
    if (!_contentView) {
        UIView * xibview = [self createFromNib];
        _contentView = xibview;
        [self addSubview:_contentView];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [_contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    }
}
- (NSArray * ) viewsFromNib{
    NSFileManager * fm= [NSFileManager defaultManager];
    NSString * nibName = NSStringFromClass([self class]);
    NSString * nibFilePath = [[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"];
    if([fm fileExistsAtPath:nibFilePath]){
        NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        return nibViews;
    }
    return nil;
}
- (instancetype) createFromNib{
    NSArray * nibViews=[self viewsFromNib];
    if (nibViews&&nibViews.count>0) {
        return nibViews[0];
    }
    return nil;
}
- (void)setContentViewTag:(NSInteger)contentViewTag{
    _contentViewTag = contentViewTag;
    NSArray * nibViews=[self viewsFromNib];
    for (UIView * v in nibViews) {
        if (v.tag == _contentViewTag) {
            if (_contentView != v) {
                [_contentView removeFromSuperview];
                _contentView = v;
                [self addSubview:_contentView];
                _contentView.translatesAutoresizingMaskIntoConstraints = NO;
                [_contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
                return;
            }
        }
    }
}
@end
