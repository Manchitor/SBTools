//
//  SBTools+MD5.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/14.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools.h"
NS_ASSUME_NONNULL_BEGIN

NSString *sb_md5(NSString *string);

@interface SBTools (MD5)

/**
 *  md5编码
 */
+ (NSString *)SB_MD5:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
