//
//  NSMutableDictionary+Ext.h
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/10.
//  Copyright © 2018年 lyj All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Ext)

/**
 *  数组的深拷贝
 *
 *  @return 拷贝后的数组
 */
- (NSMutableDictionary *)mutableDeepCopy;

/**
 * 保存值时防止崩溃
 */
- (void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey;

/**
 * 保存int值时防止崩溃
 */
- (void)setInt:(int)intValue forKey:(id<NSCopying>)aKey;

/**
 * 保存double值时防止崩溃
 */
- (void)setDouble:(double)doubleValue forKey:(id<NSCopying>)aKey;

/**
 * 保存float值时防止崩溃
 */
- (void)setFloat:(float)floatValue forKey:(id<NSCopying>)aKey;
@end
