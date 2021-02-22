//
//  NSString+URL.h
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/17.
//  Copyright © 2018年 lyj All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)
/**
 * 转换成URL
 */
- (NSURL *)toURL;

/**
 * 把URL进行UTF8转码
 */
- (NSString *)URLEncode;
@end
