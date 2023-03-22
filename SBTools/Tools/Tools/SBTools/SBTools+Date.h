//
//  SBTools+Date.h
//  Tools
//
//  Created by 刘永吉 on 2021/2/22.
//  Copyright © 2021 lyj. All rights reserved.
//

#import "SBTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBTools (Date)

/// 将时间格式化字符串
/// @param date 时间
/// @param fromatter 格式化样式
+ (NSString *)sb_date_date_to_string:(NSDate *)date fromatter:(NSString *)fromatter;


/// 将字符串格式化时间
/// @param dateString 时间字符串
/// @param fromatter 格式化样式
+ (NSDate *)sb_date_string_to_date:(NSString *)dateString fromatter:(NSString *)fromatter;

/// 判断两个时间是否相等 精确到秒级
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_date:(NSDate *)anotherDate date:(NSDate *)date;


/// 判断两个时间是否为同一个分钟
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_mins:(NSDate *)anotherDate date:(NSDate *)date;


/// 判断两个时间是否为同一个小时
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_hours:(NSDate *)anotherDate date:(NSDate *)date;


/// 判断两个时间是否为同一天
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_day:(NSDate *)anotherDate date:(NSDate *)date;


/// 判断两个时间是否为同一个月
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_month:(NSDate *)anotherDate date:(NSDate *)date;


/// 判断两个时间是否为同一个年
/// @param anotherDate 某一时间
/// @param date 另外一时间
+ (BOOL)sb_date_same_year:(NSDate *)anotherDate date:(NSDate *)date;



/// 获取当前时间戳：秒，毫秒的话要*1000
+ (long)sb_date_time_interval;


/// 时间戳转化为实践格式字符串
/// @param timestamp 毫秒值
/// @param formatter 格式化样式
+ (NSString*)sb_date_time_interval_to_string:(NSString*)timestamp  dateFormatter:(NSString *)formatter;


/// 将时间字符串转化成时间戳 精确到毫秒
/// @param str 时间格式的字符串
/// @param formatter 格式化样式
+ (long)sb_date_string_to_time_interval:(NSString*)str dateFormatter:(NSString *)formatter;


/// 将时间字符串转为几分钟前、几天前、、、、
/// @param dateString 时间字符串
/// @param formatter 格式化样式
+ (NSString*)sb_date_turn_to_history:(NSString*)dateString dateFormatter:(NSString *)formatter;
@end

NS_ASSUME_NONNULL_END
