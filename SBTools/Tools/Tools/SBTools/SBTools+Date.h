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
#pragma mark - 日期时间自身信息获取

+ (NSString *)stringFromDate24:(NSDate *)date;

/**
 *  24小时制 字符串转日期 转换的格式yyyy-MM-dd HH:mm:ss
 *
 *  @param dateString 日期字符串
 *
 *  @return date
 */
+ (NSDate *)dateFromString24:(NSString *)dateString;

/**
 *  12小时制 日期转字符串 转换的格式yyyy-MM-dd hh:mm:ss
 *
 *  @param date 日期
 *
 *  @return 格式化字符串
 */
+ (NSString *)stringFromDate12:(NSDate *)date;

/**
 *  12小时制 字符串转日期 转换的格式yyyy-MM-dd hh:mm:ss
 *
 *  @param dateString 日期字符串
 *
 *  @return date
 */
+ (NSDate *)dateFromString12:(NSString *)dateString;

/**
 *  日期转字符串 转换的格式yyyy-MM-dd
 *
 *  @param date 日期
 *
 *  @return 格式化字符串
 */
+ (NSString *)stringFromDay:(NSDate *)date;

/**
 *  字符串转日期 转换的格式yyyy-MM-dd
 *
 *  @param dateString 日期字符串
 *
 *  @return date
 */
+ (NSDate *)dayFromString:(NSString *)dateString;

/**
 *  24小时制 时间转字符串 转换的格式HH:mm:ss
 *
 *  @param time 时间
 *
 *  @return 格式化字符串
 */
+ (NSString *)stringFromTime24:(NSDate *)time;

/**
 *  24小时制 字符串转时间 转换的格式HH:mm:ss
 *
 *  @param timeString 时间字符串
 *
 *  @return time
 */
+ (NSDate *)timeFromString24:(NSString *)timeString;

/**
 *  12小时制 时间转字符串 转换的格式hh:mm:ss
 *
 *  @param time 时间
 *
 *  @return 格式化字符串
 */
+ (NSString *)stringFromTime12:(NSDate *)time;

/**
 *  12小时制 字符串转时间 转换的格式hh:mm:ss
 *
 *  @param timeString 时间字符串
 *
 *  @return time
 */
+ (NSDate *)timeFromString12:(NSString *)timeString;

/**
 *  时间转字符串 转换的格式format
 *
 *  @param time 时间
 *  @param format 自定义日期时间格式
 *
 *  @return 格式化字符串
 */
+ (NSString *)stringFromTime:(NSDate *)time format:(NSString*)format;

/**
 *  字符串转时间 转换的格式format
 *
 *  @param timeString 时间字符串
 *  @param format 自定义日期时间格式
 *
 *  @return time
 */
+ (NSDate *)timeFromString:(NSString *)timeString format:(NSString*)format;

/**
 *  字符串转时间再传回时间字符串
 *
 *  @param time 时间字符串
 *
 *  @return 时间字符串
 */
+(NSString *)dateWithSting:(NSString*)time;

/**
 *  字符串时间转date
 *
 *  @param string          时间字符串
 *  @param formatterString 时间格式
 *
 *  @return 返回date
 */
+ (NSDate *)dateFromString:(NSString *)string ForDateFormatter:(NSString *)formatterString;
/**
 *  date转字符串时间
 *
 *  @param date            date
 *  @param formatterString 时间格式
 *
 *  @return 字符串时间
 */
+ (NSString *)stringFromDate:(NSDate *)date ForDateFormatter:(NSString *)formatterString;
/**
 *  date转字符串时间消除8小时误差
 *
 *  @param date            date
 *  @param formatterString 时间格式
 *
 *  @return 字符串时间
 */
+ (NSString *)stringFromDateN:(NSDate *)date ForDateFormatter:(NSString *)formatterString;
/**
 *  字符串时间转date消除8小时误差
 *
 *  @param string          时间字符串
 *  @param formatterString 时间格式
 *
 *  @return 返回date
 */
+ (NSDate *)dateFromStringN:(NSString *)string ForDateFormatter:(NSString *)formatterString;

/**
 *  获取当前系统时间
 *
 *  @return date时间
 */
+ (NSDate *)currentDate;


/**
 *  日期是否相等
 */
+ (BOOL)isSameDay:(NSDate *)anotherDate withDate:(NSDate *)date;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
+ (BOOL)isTodayWithDate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
