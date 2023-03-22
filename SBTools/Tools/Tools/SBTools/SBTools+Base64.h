//
//  SBTools+Base64.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/17.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBTools (Base64)


/// base64加密 （RFC 4648规范）
/// @param input 需要加密的字符串
+ (NSString*)sb_base64_encode_string:(NSString*)input;

/// base64解密 （RFC 4648规范）
/// @param input 需要解密的字符串
+ (NSString*)sb_base64_decode_string:(NSString*)input;

/// base64加密 （RFC 4648规范）
/// @param data 需要加密的进制数据
+ (NSString*)sb_base64_encode_data:(NSData*)data;

/// base64解密 （RFC 4648规范）
/// @param data 需要加密的进制数据
+ (NSString*)sb_base64_decode_data:(NSData*)data;

@end

NS_ASSUME_NONNULL_END
