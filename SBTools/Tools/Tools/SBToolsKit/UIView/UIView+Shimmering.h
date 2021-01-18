//
//  UIView+Shimmering.h
//  Tools
//
//  Created by 刘永吉 on 2021/1/14.
//  Copyright © 2021 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, SBShimmeringViewStyle) {
    SBShimmeringViewStyleOverallFilling,   // 歌词模式
    SBShimmeringViewStyleFadeLeftToRight,  // 从左到右解锁模式
    SBShimmeringViewStyleFadeRightToLeft,  // 从右到左解锁模式
    SBShimmeringViewStyleFadeReverse,      // 从左右循环（秘籍~反复横跳）
    SBShimmeringViewStyleFadeAll           // 整体闪烁
};


@interface UIView (Shimmering)

/**
 *  准备shimmering的文字
 */
@property (nonatomic,strong) NSString *text;
/**
 *  shimmering文字的对其方式
 */
@property (nonatomic,assign) NSTextAlignment textAlignment;
/**
 *  shimmering文字的底层颜色
 */
@property (nonatomic,strong) UIColor *backColor;
/**
 *  shimmering文字的闪动颜色
 */
@property (nonatomic,strong) UIColor *textColor;
/**
 *  shimmering文字的大小
 */
@property (nonatomic,strong) UIFont *font;

/**
 *  开始执行shimmering动画效果
 */
- (void)startShimmeringWithType:(SBShimmeringViewStyle)type Duration:(NSTimeInterval)duration;

/**
 *  结束执行shimmering动画效果
 */
- (void)stopShimmering;


@property (nonatomic,strong) UILabel *backLabel;


@property (nonatomic,strong) UILabel *frontLabel;

@end

NS_ASSUME_NONNULL_END
