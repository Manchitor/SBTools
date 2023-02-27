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

#pragma mark ----------判读是否为空或输入只有空格
/// 判读是否为空或输入只有空格
/// @param string 字符串
BOOL sb_isEmptyString(NSString *string);

/// 判读对象是否为空
BOOL sb_isEmptyObject(id data);


#pragma mark ----------汉字转拼音
/// 汉字转拼音
/// @param chinese 汉字
+ (NSString *)sbTtransformChineseToPinyin:(NSString *)chinese;


#pragma mark ----------字符串去掉换行空格
/// 汉字去掉换行空格
/// @param string 字符串
+(NSString *)sbTransformSpaceReplacing:(NSString *)string;


#pragma mark ----------手机号格式化处理344
/// 手机号格式化处理344
/// @param intputPhone 手机号
+ (NSString *)sbFormatPhone:(NSString *)intputPhone;


#pragma mark ----------html向字符串转化
/// html向字符串转化
/// @param string html字符串
+ (NSAttributedString*)sbHtmlStringToString:(NSString *)string;


#pragma mark ----------计算字符串包含多少个汉字
/// 判断一个字符串是否包含汉字
/// @param string 字符串
+ (NSInteger )sbCountChineseContainInString:(NSString*)string;


#pragma mark ----------获取字符串高度 宽度
/// 获取字符串高度 宽度
/// @param font 字体
/// @param text 内容
/// @param maxWidth 最大宽度
+ (CGSize)sbSizeWithFont:(UIFont *)font text:(NSString *)text maxWidth:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
