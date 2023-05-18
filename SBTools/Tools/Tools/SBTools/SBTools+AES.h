//
//  SBTools+AES.h
//  Tools
//
//  Created by 刘永吉 on 2023/5/18.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
 
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    SBCryptorNoPadding = 0,    // 无填充
    SBCryptorPKCS7Padding = 1, // PKCS_7 | 每个字节填充字节序列的长度。 ***此填充模式使用系统方法。***
    SBCryptorZeroPadding = 2,  // 0x00 填充 | 每个字节填充 0x00
    SBCryptorANSIX923,         // 最后一个字节填充字节序列的长度，其余字节填充0x00。
    SBCryptorISO10126          // 最后一个字节填充字节序列的长度，其余字节填充随机数据。
}SBCryptorPadding;

typedef enum {
    SBKeySizeAES128          = 16,
    SBKeySizeAES192          = 24,
    SBKeySizeAES256          = 32,
}SBKeySizeAES;

typedef enum {
    SBModeECB        = 1,
    SBModeCBC        = 2,
    SBModeCFB        = 3,
    SBModeOFB        = 7,
}SBMode;
@interface SBTools (AES)
+ (NSString *)SB_AES_Encrypt:(NSString *)originalStr
                      mode:(SBMode)mode
                       key:(NSString *)key
                   keySize:(SBKeySizeAES)keySize
                        iv:(NSString * _Nullable )iv
                   padding:(SBCryptorPadding)padding;

+ (NSString *)SB_AES_Decrypt:(NSString *)originalStr
                      mode:(SBMode)mode
                       key:(NSString *)key
                   keySize:(SBKeySizeAES)keySize
                        iv:(NSString * _Nullable )iv
                   padding:(SBCryptorPadding)padding;
@end

NS_ASSUME_NONNULL_END
