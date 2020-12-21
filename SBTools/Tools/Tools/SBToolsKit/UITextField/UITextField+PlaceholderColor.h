//
//  UITextField+PlaceholderColor.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/19.
//  Copyright © 2020 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (PlaceholderColor)
/**
 * 设置占位符的文字颜色,需在设置placeholder 后调用
 *
 * @param placeholderColor 新颜色
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor;

/**
 * 设置占位符的文字字体,需在设置placeholder 后调用
 *
 * @param placeholderFont 新字体
 */
- (void)setPlaceholderFont:(UIFont *)placeholderFont;

/// 设置占位符样式 需在设置placeholder 后调用
/// @param placeholderColor 新颜色
/// @param placeholderFont 新字体
- (void) setPlaceholderColor:(UIColor *)placeholderColor
             placeholderFont:(UIFont *)placeholderFont;


@end

NS_ASSUME_NONNULL_END
