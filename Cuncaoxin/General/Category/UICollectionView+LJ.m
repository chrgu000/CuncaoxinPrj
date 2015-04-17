//
//  UICollectionView+LJ.m
//  Estay
//
//  Created by jerry on 14-11-4.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "UICollectionView+LJ.h"

@implementation UICollectionView (LJ)
//获取指定 indexpath之间的indexpath 默认不包含首尾
- (NSArray * )indexPathsBetweenIndexPath:(NSIndexPath * )fromIndexPath andIndexPath:(NSIndexPath * )toIndexPath{
   return [self indexPathsBetweenIndexPath:fromIndexPath andIndexPath:toIndexPath option:LJUICollectionViewSearchTypeIncludeNone];
}
//获取指定 indexpath之间的item数量 默认不包含首尾
- (NSInteger)numberOfItemsBetweenIndexPath:(NSIndexPath * )fromIndexPath andIndexPath:(NSIndexPath * )toIndexPath{
    return [self numberOfItemsBetweenIndexPath:fromIndexPath andIndexPath:toIndexPath option:LJUICollectionViewSearchTypeIncludeNone];
}
- (NSInteger)numberOfItemsBetweenIndexPath:(NSIndexPath * )fromIndexPath andIndexPath:(NSIndexPath * )toIndexPath option:(LJUICollectionViewSearchOption)option{
    NSAssert([self cellForItemAtIndexPath:fromIndexPath],@"fromIndexPath 所对用的cell不存在");
    NSAssert([self cellForItemAtIndexPath:toIndexPath],@"toIndexPath 所对用的cell不存在");
    NSIndexPath * startIndexPath ;
    NSIndexPath * endIndexPath ;
    if ([fromIndexPath compare:toIndexPath]==NSOrderedAscending||[fromIndexPath compare:toIndexPath]==NSOrderedSame) {
        startIndexPath=fromIndexPath;
        endIndexPath=toIndexPath;
    }else{
        startIndexPath=toIndexPath;
        endIndexPath=fromIndexPath;
    }
    
    NSInteger allItemsCount=0;
    NSInteger startSection=startIndexPath.section;
    NSInteger endSection=endIndexPath.section;
    for (NSInteger section = startSection; section<=endSection; section++) {
        NSInteger itemsCount=[self numberOfItemsInSection:section];
        NSInteger startItem=0;
        NSInteger endItem=itemsCount-1;
        if (section==startSection) {
            startItem=startIndexPath.item;
        }
        if (section==endSection) {
            endItem=endIndexPath.item;
        }
        allItemsCount+=(endItem-startItem+1);
    }
    //搜索结果至少有一个
    //判断搜索条件
    if (option==LJUICollectionViewSearchTypeIncludeNone) {
        allItemsCount-=2;
        //可能本来搜索就只有一个
        if (allItemsCount<0) {
            allItemsCount=0;
        }
    }else if (option==LJUICollectionViewSearchTypeIncludeFirstOnly || option==LJUICollectionViewSearchTypeIncludeLastOnly){
        if (allItemsCount>=2) {
            allItemsCount--;
        }
    }else if (option==LJUICollectionViewSearchTypeIncludeFirstAndLast){
        //结果默认是全包含 此处不做处理
    }
    return allItemsCount;
}
//获取指定 indexpath之间的indexpath集合  默认不包含首尾
- (NSArray * )indexPathsBetweenIndexPath:(NSIndexPath * )fromIndexPath andIndexPath:(NSIndexPath * )toIndexPath option:(LJUICollectionViewSearchOption)option{
    NSAssert([self cellForItemAtIndexPath:fromIndexPath],@"fromIndexPath 所对应的cell不存在");
    NSAssert([self cellForItemAtIndexPath:toIndexPath],@"toIndexPath 所对应的cell不存在");
    
    NSIndexPath * startIndexPath ;
    NSIndexPath * endIndexPath ;
    if ([fromIndexPath compare:toIndexPath]==NSOrderedAscending||[fromIndexPath compare:toIndexPath]==NSOrderedSame) {
        startIndexPath=fromIndexPath;
        endIndexPath=toIndexPath;
    }else{
        startIndexPath=toIndexPath;
        endIndexPath=fromIndexPath;
    }
    
    NSMutableArray * ips=[[NSMutableArray alloc]init];
    NSInteger startSection=startIndexPath.section;
    NSInteger endSection=endIndexPath.section;
    for (NSInteger section = startSection; section<=endSection; section++) {
        NSInteger itemsCount=[self numberOfItemsInSection:section];
        
        NSInteger startItem=0;
        NSInteger endItem=itemsCount-1;
        if (section==startSection) {
            startItem=startIndexPath.item;
        }
        if (section==endSection) {
            endItem=endIndexPath.item;
        }
        for (NSInteger i = startItem; i <=endItem ; i++) {
            NSIndexPath * ip=[NSIndexPath indexPathForItem:i inSection:section];
            [ips addObject:ip];
        }
    }
    //此时元素顺序 是从 toIndexPath 到 fromIndexPath 所以要做倒序，以保证返回的数组中元素的顺序 是从 fromIndexPath 到 toIndexPath 的
    if (startIndexPath==toIndexPath) {
        ips  = [NSMutableArray arrayWithArray:[[ips reverseObjectEnumerator] allObjects]];
    }
    //搜索结果至少有一个
    //判断搜索条件
    if (option==LJUICollectionViewSearchTypeIncludeNone) {
        [ips removeLastObject];
        //可能本来搜索就只有一个 所以在此移除前 先做个判断
        if (ips.count>0) {
            [ips removeObjectAtIndex:0];
        }
    }else if (option==LJUICollectionViewSearchTypeIncludeFirstOnly){
        if (ips.count>=2) {
            [ips removeLastObject];
        }
    }else if (option==LJUICollectionViewSearchTypeIncludeLastOnly){
        if (ips.count>=2) {
            [ips removeObjectAtIndex:0];
        }
    }else if (option==LJUICollectionViewSearchTypeIncludeFirstAndLast){
        //结果默认是全包含 此处不做处理
    }
    return ips;
}
@end
