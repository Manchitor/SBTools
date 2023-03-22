//
//  SBTools+Base64.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/17.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools+Base64.h"

@implementation SBTools (Base64)

/// base64加密 （RFC 4648规范）
/// @param input 需要加密的字符串
+ (NSString*)sb_base64_encode_string:(NSString*)input{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    return [SBTools sb_base64_encode_data:data];
}

/// base64解密 （RFC 4648规范）
/// @param input 需要解密的字符串
+ (NSString*)sb_base64_decode_string:(NSString*)input{
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:input options:NSDataBase64DecodingIgnoreUnknownCharacters];

    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

/// base64加密 （RFC 4648规范）
/// @param data 需要加密的进制数据
+ (NSString*)sb_base64_encode_data:(NSData*)data{
    
    NSString *result = [data base64EncodedStringWithOptions:0];
      
      return result;
}

/// base64解密 （RFC 4648规范）
/// @param data 需要加密的进制数据
+ (NSString*)sb_base64_decode_data:(NSData*)data{
    
    NSData *result = [[NSData alloc]initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];

    return [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];

}

@end
