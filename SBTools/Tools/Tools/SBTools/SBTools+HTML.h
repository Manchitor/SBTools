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
 @return 返回去掉所有HTML标签后的字符串
 */
+ (NSString *)sb_html_filter:(NSString *)html;

/**
 *  去掉html格式
 *
 *  @return 处理完后的数据
 */
+ (NSString *)sb_html_remove_format:(NSString *)str;


/// html向字符串转化 返回属性字符串：包括颜色 字体等
/// @param string html字符串
+ (NSAttributedString*)sb_html_attributed_string:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
