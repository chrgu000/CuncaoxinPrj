//
//  UITableView+LJ.m
//  Estay
//
//  Created by jerry on 14-8-3.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "UITableView+LJ.h"
#import "UIView+LJ.h"
@implementation UITableView (LJ)
- (void) autoresizingContentHeight:(CGFloat )contentHeight  maxHeight:(CGFloat) maxHeight {
    self.height=maxHeight;
    if (contentHeight<self.height&&contentHeight>0) {
        self.scrollEnabled=NO;
        self.height=contentHeight;
    }else {
        self.scrollEnabled=YES;
    }
}
@end
