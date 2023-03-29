//
//  NSString+SBCategory.h
//  Tools
//
//  Created by 刘永吉 on 2023/3/28.
//  Copyright © 2023 lyj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SBCategory)
/**
 * 转换成URL
 */
- (NSURL *)sb_to_url;

@end

NS_ASSUME_NONNULL_END
