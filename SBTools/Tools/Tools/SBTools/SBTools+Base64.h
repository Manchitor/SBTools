//
//  SBTools+Base64.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/17.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBTools (Base64)

+ (NSString*)SB_encodeBase64String:(NSString*)input;

+ (NSString*)SB_decodeBase64String:(NSString*)input;

+ (NSString*)SB_encodeBase64Data:(NSData*)data;

+ (NSString*)SB_decodeBase64Data:(NSData*)data;

@end

NS_ASSUME_NONNULL_END
