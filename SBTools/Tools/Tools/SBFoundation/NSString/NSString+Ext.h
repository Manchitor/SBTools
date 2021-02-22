//
//  NSString+Ext.h
//  BaseLib
//
//  Created by 刘永吉 on 2018/4/8.
//  Copyright © 2018年 lyj All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

/*!
 * 对NSString有用的扩展类
 */
@interface NSString (Ext)

/**
 *  去掉左边的空格
 *
 *  @return 处理后的字符串
 */
- (NSString *)trimLeft;

/**
 *  去掉右边的空格
 *
 *  @return 处理后的字符串
 */
- (NSString *)trimRight;

/**
 *  去掉两边的空格
 *
 *  @return 处理后的字符串
 */
- (NSString *)trim;

/**
 *  去掉所有空格
 *
 *  @return 处理后的字符串
 */
- (NSString *)trimAll;

/**
 *  去掉所有字母
 *
 *  @return 处理后的字符串
 */
- (NSString *)trimLetters;

/**
 *  去掉字符中中所有的指定的字符
 *
 *  @param character 指定的字符串
 *
 *  @return 处理后的字符串
 */
- (NSString *)trimCharacter:(unichar)character;

/**
 *  去掉两端的空格
 *
 *  @return 处理后的字符串
 */
- (NSString *)trimWhitespace;
/**
 *  计算行数
 *
 *  @return 返回行数
 */
- (NSUInteger)numberOfLines;

/*!
 * @brief 判断是否是空串
 *
 * @return YES表示是空串，NO表示非空
 */
- (BOOL)isEmpty;

/**
 *  判断去掉两边的空格后是否是空串
 *
 *  @return YES表示是空串，NO表示非空
 */
- (BOOL)isTrimEmpty;

/**
 获取反序字符串
 */
- (NSString *) antitone;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/** 去掉两端空格和换行符 */
- (NSString *)stringByTrimmingBlank;

/**
 添加前缀（不修改self）
 
 @param prefix 前缀
 @return 返回添加后的字符串
 */
- (NSString *)addPrefix:(NSString *)prefix;

/**
 *  添加后缀（不修改self）
 *
 *  @param subfix 后缀
 *
 *  @return 返回添加后的字符串
 */
- (NSString *)addSubfix:(NSString *)subfix;

/**
 *  从指定文件名读取文件内容
 *
 *  @param fileName 文件名，需要带文件类型，如:abc.json
 *
 *  @return 文件内容
 */
+ (NSString *)contentsOfFile:(NSString *)fileName;

/**
 *  读取指定文件名中的字符，并序列化为NSDictionary或NSArray
 *
 *  @param fileName 文件名，需要带文件类型，如:abc.json
 *
 *  @return NSDictionary或NSArra对象
 */
+ (id)jsonDataFromFileName:(NSString *)fileName;
/**
 *  计算多行的字体所占大小
 *
 *  @param font 字体
 *  @param size 限制大小
 *
 *  @return CGSize
 */
- (CGSize)sizeWithMyFont:(UIFont *)font constrainedToSize:(CGSize)size;


@end
