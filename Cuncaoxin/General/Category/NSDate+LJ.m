//
//  NSDate+LJ.m
//  Estay
//
//  Created by jerry on 14-7-20.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "NSDate+LJ.h"
#import "NSString+LJ.h"
#import <math.h>
@implementation NSDate (LJ)
//返回增加指定数量的月份后的date
- (NSDate *) addMonthsOfNum:(NSInteger)num{
    NSCalendar * calendar=[NSCalendar currentCalendar];
    NSDateComponents * monthComp=[[NSDateComponents alloc]init];
    [monthComp setMonth:num];
    return [calendar dateByAddingComponents:monthComp toDate:self options:0];
}
//返回增加指定数量的天数后的date
- (NSDate *) addDaysOfNum:(NSInteger)num{
    NSCalendar * calendar=[NSCalendar currentCalendar];
    NSDateComponents * dayComp=[[NSDateComponents alloc]init];
    [dayComp setDay:num];
    return [calendar dateByAddingComponents:dayComp toDate:self options:0];
}
- (NSInteger) weekDay{
    NSCalendar * calendar=[NSCalendar currentCalendar];
    return([calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self]-1);
}
- (NSString * ) weekDayString{
    NSInteger weekDay=self.weekDay;
    switch (weekDay) {
        case 0:
            return @"日";
            break;
        case 1:
            return @"一";
            break;
        case 2:
            return @"二";
            break;
        case 3:
            return @"三";
            break;
        case 4:
            return @"四";
            break;
        case 5:
            return @"五";
            break;
        case 6:
            return @"六";
            break;
    }
    NSString * msg= [NSString stringWithFormat:@"计算date在一周中是第几天时出错，未走进分支 weekDay值：%d 正确范围 0-6",weekDay];
    NSAssert(1==2,msg);
    return @"";
}

- (NSString * ) stringWithFormat:(NSString * )format{
    NSDateFormatter * df=[[NSDateFormatter   alloc]init];
    [df setDateFormat:format];
    return [df stringFromDate:self];
}
//返回当前日期从指定日期开始 过了多少天
- (NSInteger) daysBetweentCurrentAndDate:(NSDate * )date{
    NSDate * sDate = [[date stringWithFormat:@"yyyyMMdd"] dateWithFormat:@"yyyyMMdd"];
    NSDate * eDate = [[self stringWithFormat:@"yyyyMMdd"] dateWithFormat:@"yyyyMMdd"];
    return (NSInteger)ceil([eDate timeIntervalSinceDate:sDate] / (24*3600));
}

- (NSInteger)year{
    NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    NSInteger unitFlags = NSYearCalendarUnit;
    NSCalendar * calendar=[NSCalendar currentCalendar];
    comps = [calendar components:unitFlags fromDate:self];
    return comps.year;
}
- (NSInteger)month{
    NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    NSInteger unitFlags =NSMonthCalendarUnit;
    NSCalendar * calendar=[NSCalendar currentCalendar];
    comps = [calendar components:unitFlags fromDate:self];
    return comps.month;
}
- (NSInteger)day{
    NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    NSInteger unitFlags =NSDayCalendarUnit;
    NSCalendar * calendar=[NSCalendar currentCalendar];
    comps = [calendar components:unitFlags fromDate:self];
    return comps.day;
}
-(NSInteger) dayOfTheSpecifiedDates:(NSArray *)datesArr{
    if (datesArr.count<=0) {
        return -1;
    }
    NSArray * sortedDatesArr = [datesArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSDate *)obj1 compare:(NSDate *)obj2];
    }];
    NSDate * firstDate = sortedDatesArr[0];
    NSInteger dayOf = [self daysBetweentCurrentAndDate:firstDate];
    if (dayOf==0) {
        dayOf = 1;
    }else{
        ++dayOf;
    }
    return dayOf;
}
#pragma mark 当前日志 与指定日期是否是同一天
- (BOOL) isSameDayAs:(NSDate *) date{
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    if (
        (int)(([self timeIntervalSince1970] + timezoneFix)/(24*3600)) -
        (int)(([date timeIntervalSince1970] + timezoneFix)/(24*3600))
        == 0)
    {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark 当前日期 与指定日期是否是同一月
- (BOOL) isSameMonthAs:(NSDate *) date{
    if ([self isSameYearAs:date]) {
        if (self.month==date.month) {
            return YES;
        }
    }
    return NO;
}
#pragma mark 当前日期 与指定日期是否是同一年
- (BOOL) isSameYearAs:(NSDate *) date{
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    if (
        (int)(([self timeIntervalSince1970] + timezoneFix)/(24*3600*365)) -
        (int)(([date timeIntervalSince1970] + timezoneFix)/(24*3600*365))
        == 0)
    {
        return YES;
    }else{
        return NO;
    }
}
@end
