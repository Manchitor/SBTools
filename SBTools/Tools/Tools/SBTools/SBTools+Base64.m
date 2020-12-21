//
//  SBTools+Base64.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/17.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools+Base64.h"

@implementation SBTools (Base64)

+ (NSString*)SB_encodeBase64String:(NSString* )input {

    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];

    return [SBTools SB_encodeBase64Data:data];

}

+ (NSString*)SB_decodeBase64String:(NSString* )input {

    NSData *data = [[NSData alloc]initWithBase64EncodedString:input options:NSDataBase64DecodingIgnoreUnknownCharacters];

    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString*)SB_encodeBase64Data:(NSData*)input {
    
  NSString *result = [input base64EncodedStringWithOptions:0];
    
    return result;

}

+ (NSString*)SB_decodeBase64Data:(NSData*)input {

    NSData *data = [[NSData alloc]initWithBase64EncodedData:input options:NSDataBase64DecodingIgnoreUnknownCharacters];

    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

}


@end
