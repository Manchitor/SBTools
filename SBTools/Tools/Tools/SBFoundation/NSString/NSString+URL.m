//
//  NSString+URL.m
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/17.
//  Copyright © 2018年 lyj All rights reserved.
//

#import "NSString+URL.h"
#import "NSString+Category.h"

@implementation NSString (URL)

- (NSURL *)toURL
{
    return [NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}

- (NSString *)URLEncode
{
    
    NSString *result = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [result trim];
}

@end
