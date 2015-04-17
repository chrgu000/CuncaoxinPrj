//
//  NSDate+LJ.h
//  Estay
//
//  Created by jerry on 14-7-20.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LJ)

#pragma mark 当前date 是周几 (从0-6  0表示周末 依次类推)
@property (nonatomic,assign,readonly) NSInteger weekDay;
#pragma mark 当前date 是周几 返回 ’日‘,‘一’...
@property (nonatomic,copy,readonly) NSString * weekDayString;

@property (nonatomic,assign,readonly) NSInteger year;
@property (nonatomic,assign,readonly) NSInteger month;
@property (nonatomic,assign,readonly) NSInteger day;

#pragma mark 返回增加指定数量的月份后的date
- (NSDate *) addMonthsOfNum:(NSInteger)num;
#pragma mark 返回增加指定数量的天数后的date
- (NSDate *) addDaysOfNum:(NSInteger)num;

#pragma mark 获取指定format的date的string形式
- (NSString * ) stringWithFormat:(NSString * )format;
#pragma mark 返回当前日期与指定日期间的相差的天数
- (NSInteger) daysBetweentCurrentAndDate:(NSDate * )date;

#pragma mark 当前日期 在指定日期数组中 是第几天
-(NSInteger) dayOfTheSpecifiedDates:(NSArray *)datesArr;

#pragma mark 当前日期 与指定日期是否是同一天
- (BOOL) isSameDayAs:(NSDate *) date;
#pragma mark 当前日期 与指定日期是否是同一月
- (BOOL) isSameMonthAs:(NSDate *) date;
#pragma mark 当前日期 与指定日期是否是同一年
- (BOOL) isSameYearAs:(NSDate *) date;
@end
