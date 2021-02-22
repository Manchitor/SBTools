//
//  NSArray+Ext.h
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/10.
//  Copyright © 2018年 lyj All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Ext)

/**
 *  如果index索引值下有元素，返回该元素，否则返回nil
 *
 *  @param index 索引
 *  @return 获取到的元素或者nil
 */
- (id)safeObjectAtIndex:(NSUInteger)index;

/**
 *  返回逆序排序的数组
 *
 *  @return 逆序排序的数组
 */
- (NSArray *)reversedArray;

/**
 *  返回逆序排序的数组
 *
 *  @return 逆序排序的数组
 */
+ (NSArray *)reversedArray:(NSArray *)array;

/**
 *  将数组转换成JSON字符串
 *
 *  @return JSON字符串或者nil（转换失败）
 */
- (NSString *)toJson;

/**
 *  将数组转换成JSON字符串
 *
 *  @return JSON字符串或者nil（转换失败）
 */
+ (NSString *)toJson:(NSArray *)array;

/**
 * 判断数组中是否包含string
 */
- (BOOL)isContainsString:(NSString *)string;

/**
 *  追加数据
 */
-(NSArray *)appendArray:(NSArray *)newArray;
@end
