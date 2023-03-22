//
//  SBTools+NSString.h
//  Tools
//
//  Created by 刘永吉 on 2020/12/21.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBTools (NSString)

/// 判读是否为空或输入只有空格
/// @param string 字符串
BOOL sb_string_empty(NSString *string);


/// 汉字转拼音
/// @param chinese 汉字
+ (NSString *)sb_string_transform_pinyin:(NSString *)chinese;


/// 汉字去掉换行空格
/// @param string 字符串
+(NSString *)sb_string_trim:(NSString *)string;


/// 手机号格式化处理344 例：187 2121 8206
/// @param intputPhone 手机号
+ (NSString *)sb_string_format_phone:(NSString *)intputPhone;


/// 判断一个字符串包含汉字个数
/// @param string 字符串
+ (NSInteger )sb_string_chinese_count:(NSString*)string;


/// 获取字符串高度 宽度
/// @param font 字体
/// @param text 内容
/// @param maxWidth 最大宽度
+ (CGSize)sb_string_max_size:(UIFont *)font text:(NSString *)text maxWidth:(CGFloat)maxWidth;


/// 手机号脱敏
/// @param phone 手机号
+ (NSString*) sb_string_secrect_phone:(NSString*)phone;


/// 邮箱脱敏
/// @param email 邮箱
+ (NSString*) sb_string_secrect_email:(NSString*)email;


/// 缓存单位转换
/// @param size @(1024)
+ (NSString *)sb_string_size_unit_formatted:(NSNumber *)size;
@end

NS_ASSUME_NONNULL_END
