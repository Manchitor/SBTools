//
//  NSData+Ext.m
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/8.
//  Copyright © 2018年 lyj All rights reserved.
//

#import "NSData+Ext.h"

@implementation NSData (Ext)


- (NSString *)toString {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

+ (NSString *)toString:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
