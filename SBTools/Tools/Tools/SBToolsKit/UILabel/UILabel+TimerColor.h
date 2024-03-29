//
//  UILabel+TimerColor.h
//  Tools
//
//  Created by 刘永吉 on 2021/1/13.
//  Copyright © 2021 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (TimerColor)
/// 开启逐字变色动画
/// @param timerDuration 动画时间
/// @param timerColor 变换后的颜色
/// @param isReSetColor 动画执行完毕后是否颜色复位
-(void)sb_start_word_discoloration_animation:(CGFloat) timerDuration TimerColor:(UIColor *) timerColor isReSetColor:(BOOL) isReSetColor;

///结束变色动画
-(void)sb_end_word_discoloration_animation;




///开始闪动动画 类似iphone 滑动解锁 滑块
-(void)sb_start_slider_animation;

///结束闪动动画 类似iphone 滑动解锁 滑块
-(void)sb_end_slider_animation;
@end

NS_ASSUME_NONNULL_END
