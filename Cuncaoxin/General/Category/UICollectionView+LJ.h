//
//  UICollectionView+LJ.h
//  Estay
//
//  Created by jerry on 14-11-4.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum LJUICollectionViewSearch_option{
    LJUICollectionViewSearchTypeIncludeNone,//不包含指定搜索范首尾元素
    LJUICollectionViewSearchTypeIncludeFirstOnly,//包含指定搜索范围的第一个元素
    LJUICollectionViewSearchTypeIncludeLastOnly,//包含指定搜索范围的最后一个元素
    LJUICollectionViewSearchTypeIncludeFirstAndLast//包含指定搜索范首尾元素
}LJUICollectionViewSearchOption;
@interface UICollectionView (LJ)
//获取指定 indexpath之间的indexpath 默认不包含首尾 元素默认顺序 从fromIndexPath 到 toIndexPath
- (NSArray * )indexPathsBetweenIndexPath:(NSIndexPath * )fromIndexPath andIndexPath:(NSIndexPath * )toIndexPath;
//获取指定 indexpath之间的indexpath 元素默认顺序 从fromIndexPath 到 toIndexPath
- (NSArray * )indexPathsBetweenIndexPath:(NSIndexPath * )fromIndexPath andIndexPath:(NSIndexPath * )toIndexPath option:(LJUICollectionViewSearchOption)option;


//获取指定 indexpath之间的item数量 默认不包含首尾
- (NSInteger)numberOfItemsBetweenIndexPath:(NSIndexPath * )fromIndexPath andIndexPath:(NSIndexPath * )toIndexPath;
//获取指定 indexpath之间的item数量
- (NSInteger)numberOfItemsBetweenIndexPath:(NSIndexPath * )fromIndexPath andIndexPath:(NSIndexPath * )toIndexPath option:(LJUICollectionViewSearchOption)option;
@end
