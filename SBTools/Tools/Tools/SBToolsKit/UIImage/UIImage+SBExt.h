//
//  UIImage+SBExt.h
//  Tools
//
//  Created by 刘永吉 on 2020/9/8.
//  Copyright © 2020 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SBExt)

/**
 *  根据颜色来设置image
 *
 *  @param color 颜色
 *
 *  @return 设置好的image
 */
+ (UIImage *)sb_image_create_color:(UIColor *)color;

/**
 *  根据颜色和尺寸返回
 *
 *  @param color 颜色
 *  @param size  image的尺寸
 *
 *  @return 设置好的image
 */
+ (UIImage *)sb_image_create_color:(UIColor *)color size:(CGSize)size;


/**
 *  添加高斯效果
 *
 */
- (UIImage *)sb_image_apply_effect_blur:(CGFloat )blur;

/**
 *  截图生成图片。
 *  @param  view  UIView及其子类。
 *  @param  scale 屏幕放大倍数，1为原尺寸。
 *  return  抓取图片后的Image。
 */
+ (UIImage *)sb_image_capture_view:(UIView *)view scale:(CGFloat)scale;


@end

NS_ASSUME_NONNULL_END
