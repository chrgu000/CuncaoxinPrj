//
//  NSString+LJ.m
//  SinaBlog
//
//  Created by qianfeng on 14-6-11.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import "NSString+LJ.h"
#import "CommonCrypto/CommonDigest.h"
#import "RegexKitLite.h"
@implementation NSString (LJ)
- (NSString *) stringByAppendingGETParams:(NSDictionary * )paramsDic{
    NSString * urlstr=self;
    //没有问号表示没有参数
    if ([urlstr rangeOfString:@"?"].length<=0) {
        urlstr=[urlstr stringByAppendingString:@"?"];
    }else{//有问号 表示已经有参数 需要加上参数连接符 '&'
        urlstr=[urlstr stringByAppendingString:@"&"];
    }
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSArray * allkeys=paramsDic.allKeys;
    for (int i=0; i<allkeys.count;i++) {
        NSString * key=allkeys[i];
        id value=paramsDic[key];
        if([value isKindOfClass:[NSNumber class]]){
            value = [numberFormatter stringFromNumber:value];
        }
        urlstr=[urlstr stringByAppendingFormat:@"%@=%@",key,[((NSString *)value) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
        if (i!=allkeys.count-1) {
            urlstr=[urlstr stringByAppendingString:@"&"];
        }
    }
    
    return urlstr;
}
- (CGFloat) getAutosizeHeightWithFont:(UIFont *)font andWidth:(CGFloat)width{
    NSDictionary * arrDic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGRect f=[self boundingRectWithSize:CGSizeMake(width, 1000.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrDic context:Nil];
    
    return f.size.height;
}
- (CGRect) getAutosizeRectWithFont:(UIFont *)font andWidth:(CGFloat)width{
    NSDictionary * arrDic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGRect f=[self boundingRectWithSize:CGSizeMake(width, 1000.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrDic context:Nil];
    
    return f;
}
//转换成json
- (id) jsonObject{
    id rspObj=  [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    return rspObj;
}
//获取文字在单行模式下 自适应的size
- (CGSize) getSingleLineSize:(UIFont * )font{
    NSDictionary * arrDic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGRect f=[self boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrDic context:Nil];
    
    return f.size;
}

//获取单行文字的长度
- (CGFloat) getSingleLineWidthWithFont:(UIFont * )font{
    NSDictionary * arrDic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGRect f=[self boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrDic context:Nil];
    
    return f.size.width;
}
//获取单行文字的高度
- (CGFloat) getSingleLineHeightWithFont:(UIFont * )font{
    NSDictionary * arrDic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGRect f=[self boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrDic context:Nil];
    return f.size.height;
}
//大写第一个字母
- (NSString * ) upperFirstChar{
    NSString * fcs= [ NSString stringWithFormat:@"%c",[self characterAtIndex:0]];
    return  [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[fcs uppercaseString]];
}
//小写第一个字母
- (NSString * ) lowerFirstChar{
    NSString * fcs= [ NSString stringWithFormat:@"%c",[self characterAtIndex:0]];
    return  [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[fcs lowercaseString]];
}
- (NSString * )trim{
    NSString *cleanString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return cleanString;
}
+ (BOOL) isEmpty:(NSString * )str{
    if (!str||(NSNull *)str==[NSNull null]||[str trim].length<=0) {
        return YES;
    }
    return NO;
}
#pragma mark 日期相关
- (NSDate * ) dateWithFormat:(NSString * )format{
    NSDateFormatter * df=[[NSDateFormatter alloc]init];
    [df setDateFormat:format];
    return [df dateFromString:self];
}
- (NSString * )md5_16{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
    
}
- (NSString * )md5_32{
        const char *cStr = [self UTF8String];
        unsigned char result[32];
        CC_MD5( cStr, strlen(cStr), result );
        return [NSString stringWithFormat:
                @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                result[0],result[1],result[2],result[3],
                result[4],result[5],result[6],result[7],
                result[8],result[9],result[10],result[11],
                result[12],result[13],result[14],result[15],
                result[16], result[17],result[18], result[19],
                result[20], result[21],result[22], result[23],
                result[24], result[25],result[26], result[27],
                result[28], result[29],result[30], result[31]];
    
}
- (BOOL) isMatchPhoneNum{
  return [self.trim isMatchedByRegex:@"\\d{11}"]&&(self.trim.length==11);
}
- (BOOL) isMatchIntegerNums{
    return [self.trim isMatchedByRegex:@"^\\d+$"];
}

#pragma mark 截取最多指定数目的字符 从0开始
- (NSString * )substringCharactersOfUpToNumber:(NSInteger )number{
    if (number<=0) {
        return nil;
    }
    return  self.length>=number?[self substringToIndex:number]:self;
}
#pragma mark 截取最多指定数目的字符 从指定索引处开始
- (NSString * )substringCharactersOfUpToNumber:(NSInteger )number startIndex:(NSInteger)startIndex{
    if (number<=0 || startIndex>=self.length) {
        return nil;
    }
    return  self.length>=(number+startIndex)?[self substringWithRange:NSMakeRange(startIndex, number)]:[self substringFromIndex:startIndex];
}
+ (NSComparisonResult) compareVersion:(NSString * )version1 toVersion:(NSString * )version2{
    NSArray * version1Nums=[version1 componentsSeparatedByString:@"."];
    NSArray * version2Nums=[version2 componentsSeparatedByString:@"."];
    NSInteger shortVersionNumsCount=MIN(version1Nums.count, version2Nums.count);
    for (NSInteger i = 0 ; i<shortVersionNumsCount; i++) {
        NSInteger v1Num=[version1Nums[i] integerValue];
        NSInteger v2Num=[version2Nums[i] integerValue];
        if (v1Num<v2Num) {
            return NSOrderedAscending;
        }else if (v1Num==v2Num){
            //如果已经是最后一位 则位数多的并且多出来的数字不全是0的版本号大
            if (i==shortVersionNumsCount-1) {
                if (version1Nums.count>version2Nums.count) {
                    for (NSInteger m = i+1; m < version1Nums.count; m++) {
                        NSInteger num = [version1Nums[m] integerValue];
                        
                        //如果多出的数字中有一位不是0 那么长的版本号则是大版本号
                        if (num!=0) {
                            return NSOrderedDescending;
                        }
                    }
                    return NSOrderedSame;
                    
                }else if (version1Nums.count<version2Nums.count){
                    for (NSInteger m = i+1; m < version2Nums.count; m++) {
                        NSInteger num = [version2Nums[m] integerValue];
                        if (num!=0) {
                            return NSOrderedAscending;
                        }
                    }
                    return NSOrderedSame;
                }else{
                    return NSOrderedSame;
                }
            }else{//不是最后一位 则继续比较
                continue;
            }
            
        }else{
            return NSOrderedDescending;
        }
    }
    //理论上不可能运行到此处 (若运行至此处 则说明出现了以上判断逻辑之外的情况)
#ifdef DEBUG
    NSAssert(1==2,@"版本比较方法出问题 请检查");
#endif
    return NSOrderedSame;
}
@end
