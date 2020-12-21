//
//  SBTools+MD5.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/14.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools+MD5.h"
#import <CommonCrypto/CommonKeyDerivation.h>

NSString *sb_md5(NSString *string)
{
    return [SBTools SB_MD5:string];
}
@implementation SBTools (MD5)

+(NSString *)SB_MD5:(NSString *)string{
    
    if (string == nil || [string length] == 0){
        
        NSLog(@"MD5加密时请输入合法的字符串！！！！！");
        
        return nil;
        
    }
    NSMutableString *md5String = [NSMutableString string];
    
    const char *cString = [string UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        
        [md5String appendFormat:@"%02x",result[i]];
        
    }
    
    return md5String;
}

@end
