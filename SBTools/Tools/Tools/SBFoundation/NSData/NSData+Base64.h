//
//  NSData+Base64.h
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/8.
//  Copyright © 2018年 lyj All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

/**
 *  base64编码
 *
 *  @return 编码后的数据
 */
- (NSString *)base64Encoding;

/**
 *  base64编码
 *
 *  @return 编码后的数据
 */
+ (NSString *)base64Encoding:(NSData*)data;


@end
