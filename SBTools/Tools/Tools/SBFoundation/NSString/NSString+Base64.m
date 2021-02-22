//
//  NSString+Base64.m
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/8.
//  Copyright © 2018年 lyj All rights reserved.
//

#import "NSString+Base64.h"

@implementation NSString (Base64)

- (NSString *)base64Encoding
{
    return [NSString base64Encoding:self];
}

+ (NSString *)base64Encoding:(NSString *)text
{
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSString *result = nil;
    
    result = [data base64EncodedStringWithOptions:0];
    
    return result;
}
@end
