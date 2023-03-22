//
//  SBTools+MD5.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/14.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools+MD5.h"
#import <CommonCrypto/CommonKeyDerivation.h>

/// md5编码
/// @param string 需要进行编码的字符串 默认返回32位小写结果
NSString *sb_md5_string(NSString *string){
    return [SBTools SB_MD5:string];
}

@implementation SBTools (MD5)

/// md5编码
/// @param string 需要进行编码的字符串 默认返回32位小写结果
+ (NSString *)SB_MD5:(NSString *)string{
    return [SBTools SB_MD5:string MaxBit:YES Uppercase:NO];
}


/// md5编码
/// @param string 需要进行编码的字符串
/// @param maxBit 编码结果是否是最大位数32位。NO:16位
/// @param uppercase 编码结果是否为大写
+ (NSString *)SB_MD5:(NSString *)string MaxBit:(BOOL)maxBit Uppercase:(BOOL)uppercase{
    
    if (string == nil || [string length] == 0){
        NSLog(@"MD5加密时请输入合法的字符串！！！！！");
        return nil;
    }
    
    NSMutableString *md5String = [NSMutableString string];
    
    const char *cString = [string UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        //大小写处理
        if (uppercase) {
            [md5String appendFormat:@"%02X",result[i]];
        }else{
            [md5String appendFormat:@"%02x",result[i]];
        }
    }
    
    //位数处理
    if (maxBit) {
        return md5String;
    }
    
    return [md5String substringWithRange:NSMakeRange(8, 16)];
}

@end
