//
//  NSData+Base64.m
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/8.
//  Copyright © 2018年 lyj All rights reserved.
//

#import "NSData+Base64.h"

@implementation NSData (Base64)

- (NSString *)base64Encoding
{
    NSString *result = nil;
    result = [self base64EncodedStringWithOptions:0];
    return result;
}

+ (NSString *)base64Encoding:(NSData*)data
{
    NSString *result = nil;
    result = [data base64EncodedStringWithOptions:0];
    return result;
}
@end
