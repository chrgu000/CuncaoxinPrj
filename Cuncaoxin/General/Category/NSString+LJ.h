//
//  NSString+LJ.h
//  SinaBlog
//
//  Created by qianfeng on 14-6-11.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LJ)
@property (nonatomic,copy,readonly) NSString * trim;
#pragma mark --------------------------------------- 格式化 ---------------------------------------
#pragma mark 大写第一个字母
- (NSString * ) upperFirstChar;
#pragma mark 小写第一个字母
- (NSString * ) lowerFirstChar;
#pragma mark 以GET形式拼接参数
- (NSString *) stringByAppendingGETParams:(NSDictionary * )paramsDic;

#pragma mark --------------------------------------- 验证 ---------------------------------------
#pragma mark 是否是正确的手机号
- (BOOL) isMatchPhoneNum;
#pragma mark 是否是数字
- (BOOL) isMatchIntegerNums;
#pragma mark 是否为空
+ (BOOL) isEmpty:(NSString * )str;

#pragma mark --------------------------------------- size ---------------------------------------
#pragma mark 文字size相关
- (CGFloat) getAutosizeHeightWithFont:(UIFont *)font andWidth:(CGFloat)width;
- (CGRect) getAutosizeRectWithFont:(UIFont *)font andWidth:(CGFloat)width;
- (CGSize) getSingleLineSize:(UIFont * )font;
- (CGFloat) getSingleLineWidthWithFont:(UIFont * )font;
- (CGFloat) getSingleLineHeightWithFont:(UIFont * )font;

#pragma mark --------------------------------------- 其他 ---------------------------------------
#pragma mark md5
- (NSString * )md5_16;
- (NSString * )md5_32;
#pragma mark 转换成json 对象 (NSDictionary)
- (id) jsonObject;
#pragma mark 日期相关
- (NSDate * ) dateWithFormat:(NSString * )format;

#pragma mark 截取最多指定数目的字符 从0开始
- (NSString * )substringCharactersOfUpToNumber:(NSInteger )number;
#pragma mark 截取最多指定数目的字符 从指定索引处开始
- (NSString * )substringCharactersOfUpToNumber:(NSInteger )number startIndex:(NSInteger)startIndex;
#pragma mark 比较两个版本 字符串 例如："1.2.3"、"2.3.1"
+ (NSComparisonResult) compareVersion:(NSString * )version1 toVersion:(NSString * )version2;
@end
