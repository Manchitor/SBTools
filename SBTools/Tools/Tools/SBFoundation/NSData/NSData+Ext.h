//
//  NSData+Ext.h
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/8.
//  Copyright © 2018年 lyj All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Ext)

/*
 *  将二进制转换成字符串
 *
 *  @return 字符串
 */
- (NSString *)toString;

/*
 *  将二进制转换成字符串
 *
 *  @return 字符串
 */
+ (NSString *)toString:(NSData *)data;


@end
