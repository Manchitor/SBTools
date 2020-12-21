//
//  SBTools+HTML.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/17.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBTools (HTML)
/**
 过滤掉HTML标签
 
 @param html HTML内容
 @return 返回喜欢去掉所有HTML标签后的字符串
 */
+ (NSString *)SB_filterHTML:(NSString *)html;

/**
 *  去掉html格式
 *
 *  @return 处理完后的数据
 */
+ (NSString *)SB_removeHtmlFormat;
@end

NS_ASSUME_NONNULL_END
