//
//  NSString+TFEncrypt.h
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/17.
//  Copyright © 2018年 lyj All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TFEncrypt)
/**
 *  md5加密
 *
 */
- (NSString *)md5;

/**
 *  SHA1加密
 *
 */
- (NSString *)SHA1;

/**
 *  SHA256加密
 *
 */
- (NSString *)SHA256;

/**
 *  SHA512加密
 *
 */
- (NSString *)SHA512;
@end
