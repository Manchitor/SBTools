//
//  NSData+Encrypt.h
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/8.
//  Copyright © 2018年 lyj All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSError+Category.h"

@interface NSData (Encrypt)

/**
 * MD2加密算法
 */
- (NSData *)MD2;

/**
 * MD4加密算法
 */
- (NSData *)MD4;

/**
 * MD5加密算法
 */
- (NSData *)MD5;

/**
 * SHA1加密算法
 */
- (NSData *)SHA1;

/**
 * SHA224加密算法
 */
- (NSData *)SHA224;

/**
 * SHA256加密算法
 */
- (NSData *)SHA256;

/**
 * SHA384加密算法
 */
- (NSData *)SHA384;

/**
 * SHA512加密算法
 */
- (NSData *)SHA512;

/**
 * AES256加密
 */
- (NSData *)AES256EncryptedUsingKey:(id)key error:(NSError **)error;

/**
 * AES256解密
 */
- (NSData *)AES256DecryptedUsingKey:(id)key error:(NSError **)error;

/**
 * DES加密
 */
- (NSData *)DESEncryptedUsingKey:(id)key error:(NSError **)error;

/**
 * DES解密
 */
- (NSData *)DESDecryptedUsingKey:(id)key error:(NSError **)error;

/**
 * CAST加密
 */
- (NSData *)CASTEncryptedUsingKey:(id)key error:(NSError **)error;

/**
 * CAST解密
 */
- (NSData *)CASTDecryptedUsingKey:(id)key error:(NSError **)error;

/**
 * 弱加密算法
 */
- (NSData *)dataEncryptedUsingAlgorithm:(CCAlgorithm)algorithm
                                    key:(id)key        // data or string
                                  error:(CCCryptorStatus *)error;

- (NSData *)dataEncryptedUsingAlgorithm:(CCAlgorithm)algorithm
                                    key:(id)key        // data or string
                                options:(CCOptions) options
                                  error:(CCCryptorStatus *) error;

- (NSData *)dataEncryptedUsingAlgorithm:(CCAlgorithm) algorithm
                                    key:(id)key        // data or string
                   initializationVector:(id)iv        // data or string
                                options:(CCOptions)options
                                  error:(CCCryptorStatus *)error;
/**
 * 弱解密算法
 */
- (NSData *)decryptedDataUsingAlgorithm:(CCAlgorithm)algorithm
                                    key:(id)key        // data or string
                                  error:(CCCryptorStatus *)error;
- (NSData *)decryptedDataUsingAlgorithm:(CCAlgorithm)algorithm
                                    key:(id)key        // data or string
                                options:(CCOptions)options
                                  error:(CCCryptorStatus *)error;
- (NSData *)decryptedDataUsingAlgorithm:(CCAlgorithm)algorithm
                                    key:(id)key        // data or string
                   initializationVector:(id)iv        // data or string
                                options:(CCOptions)options
                                  error:(CCCryptorStatus *)error;


@end
