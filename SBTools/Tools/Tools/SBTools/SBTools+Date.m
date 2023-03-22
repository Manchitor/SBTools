//
//  SBTools+Date.m
//  Tools
//
//  Created by 刘永吉 on 2021/2/22.
//  Copyright © 2021 lyj. All rights reserved.
//

#import "SBTools+Date.h"


@implementation SBTools (Date)

/// 将时间格式化字符串
/// @param date 时间
/// @param fromatter 格式化样式
+ (NSString *)sb_date_date_to_string:(NSDate *)date fromatter:(NSString *)fromatter{
    NSDateFormatter *dateFromatter=[[NSDateFormatter alloc] init];
    [dateFromatter setDateFormat:fromatter];
    NSString *strDate = [dateFromatter stringFromDate:date];
    return strDate;
}


/// 将字符串格式化时间
/// @param dateString 时间字符串
/// @param fromatter 格式化样式
+ (NSDate *)sb_date_string_to_date:(NSString *)dateString fromatter:(NSString *)fromatter{
    NSDateFormatter *dateFromatter=[[NSDateFormatter alloc] init];
    [dateFromatter setDateFormat:fromatter];
    NSDate *date = [dateFromatter dateFromString:dateString];
    return date;
}


/// 判断两个时间是否相等 精确到秒级
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_date:(NSDate *)anotherDate date:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day] && [components1 hour] == [components2 hour] && [components1 minute] == [components2 minute] && [components1 second] == [components2 second]);
}


/// 判断两个时间是否为同一个分钟
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_mins:(NSDate *)anotherDate date:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day] && [components1 hour] == [components2 hour] && [components1 minute] == [components2 minute]);
}


/// 判断两个时间是否为同一个小时
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_hours:(NSDate *)anotherDate date:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour) fromDate:date];
    
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day] && [components1 hour] == [components2 hour]);
}


/// 判断两个时间是否为同一天
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_day:(NSDate *)anotherDate date:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
}


/// 判断两个时间是否为同一个月
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_month:(NSDate *)anotherDate date:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
    
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month]);
}


/// 判断两个时间是否为同一个年
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_year:(NSDate *)anotherDate date:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear) fromDate:date];
    
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear) fromDate:anotherDate];
    return ([components1 year] == [components2 year]);
}

/// 获取当前时间戳：秒
+ (long)sb_date_time_interval{
    NSDate *datenow = [NSDate date];//现在时间
    NSInteger timestamp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    return (long)timestamp;
}



/// 时间戳转化为实践格式字符串
/// @param timestamp 毫秒值
/// @param formatter 格式化样式
+ (NSString*)sb_date_time_interval_to_string:(NSString*)timestamp  dateFormatter:(NSString *)formatter{
    // 时间戳转日期
    // 传入的时间戳timeStr如果是精确到毫秒的记得要/1000
    NSTimeInterval timeInterval = [timestamp doubleValue]/1000;
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    // 实例化一个NSDateFormatter对象，设定时间格式，这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatter];
    
    NSString *dateStr = [dateFormatter stringFromDate:detailDate];
    return dateStr;
}


/// 将时间字符串转化成时间戳 精确到毫秒
/// @param str 时间格式的字符串
/// @param formatter 格式化样式
+ (long)sb_date_string_to_time_interval:(NSString*)str dateFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:formatter];//设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    return (long)[tempDate timeIntervalSince1970] *1000;
}


/// 将时间字符串转为几分钟前、几天前、、、、
/// @param dateString 时间字符串
/// @param formatter 格式化样式
+ (NSString*)sb_date_turn_to_history:(NSString*)dateString dateFormatter:(NSString *)formatter{
    //时间
    NSString *createdTimeStr = dateString;
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *timeDate = [dateFormatter dateFromString:createdTimeStr];
    //得到与当前时间差
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }else if((temp = timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }else if((temp = timeInterval/3600) > 1 && (temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }else if ((temp = timeInterval/3600) > 24 && (temp = timeInterval/3600) < 48){
        result = [NSString stringWithFormat:@"昨天"];
    }else if ((temp = timeInterval/3600) > 48 && (temp = timeInterval/3600) < 72){
        result = [NSString stringWithFormat:@"前天"];
    }else{
        result = createdTimeStr;
    }
    
    return createdTimeStr;
}

@end
