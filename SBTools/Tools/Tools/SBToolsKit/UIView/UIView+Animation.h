//
//  UIView+Animation.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/20.
//  Copyright © 2020 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Animation)
/**
 *  揭开动画
 *
 *  @param view      视图
 *  @param direction 动画方向 kCATransitionFromRight...
 */
+ (void)animationReveal:(UIView *)view direction:(NSString *)direction;

/**
 *  渐隐渐消动画
 *
 *  @param view 视图
 */
+ (void)animationFade:(UIView *)view;

/**
 *  翻转动画
 *
 *  @param view      视图
 *  @param direction 动画方向
 */
+ (void)animationFlip:(UIView *)view direction:(NSString *)direction;

/**
 *  旋转缩放动画
 *
 *  @param view 视图
 */
+ (void)animationRotateAndScaleEffects:(UIView *)view;

/**
 *  旋转同时缩小放大动画
 *
 *  @param view 视图
 */
+ (void)animationRotateAndScaleDownUp:(UIView *)view;

/**
 *  push动画
 *
 *  @param view      视图
 *  @param direction 动画方向
 */
+ (void)animationPush:(UIView *)view direction:(NSString *)direction;

/**
 *  Curl动画
 *
 *  @param view      视图
 *  @param direction 动画方向
 */
+ (void)animationCurl:(UIView *)view direction:(NSString *)direction;

/**
 *  Uncurl动画
 *
 *  @param view      视图
 *  @param direction 动画方向
 */
+ (void)animationUnCurl:(UIView *)view direction:(NSString *)direction;

/**
 *  Move动画
 *
 *  @param view      视图
 *  @param direction 动画方向
 */
+ (void)animationMove:(UIView *)view direction:(NSString *)direction;

/**
 *  立方体动画
 *
 *  @param view      视图
 *  @param direction 动画方向
 */
+ (void)animationCube:(UIView *)view direction:(NSString *)direction;

/**
 *  水波动画
 *
 *  @param view      视图
 */
+ (void)animationRippleEffect:(UIView *)view;

/**
 *  相机开合动画
 *
 *  @param view 视图
 *  @param type 开合类型（`fade', `moveIn', `push', `reveal'. 默认 `fade'）
 */
+ (void)animationCameraEffect:(UIView *)view type:(NSString *)type;

/**
 *  吸收动画
 *
 *  @param view      视图
 */
+ (void)animationSuckEffect:(UIView *)view;

/**
 *  弹跳减速动画
 *
 *  @param view 视图
 */
+ (void)animationBounceOut:(UIView *)view;

/**
 *  弹跳加速动画
 *
 *  @param view 视图
 */
+ (void)animationBounceIn:(UIView *)view;

/**
 *  弹跳动画
 *
 *  @param view 视图
 */
+ (void)animationBounce:(UIView *)view;

/**
 *  添加抖动效果
 */
- (void)shakeView;

/**
 *  添加放大后又缩小的动画
 *
 *  @param completion 动画完成回调
 */
- (void)addScaleAnimationWithCompletion:(void(^)(void))completion;

/**
 *  添加放大后又缩小的动画
 *
 *  @param scale      放大缩小比例
 *  @param completion 动画完成回调
 */
- (void)addScaleAnimation:(CGPoint)scale completion:(void(^)(void))completion;

/**
 *  添加压下的动画
 *
 *  @param completion 动画完成回调
 */
- (void)addDownAnimationWithCompletion:(void(^)(void))completion;

/**
 *  添加压下的动画
 *
 *  @param scale      压下比例
 *  @param completion 动画完成回调
 */
- (void)addDownAnimation:(CGPoint)scale completion:(void(^)(void))completion;

/**
 *  添加淡入淡出的动画
 *
 *  @param duration 动画时长
 */
- (void)fadeWithDuration:(NSTimeInterval)duration;

/**
 *  添加淡入淡出的动画
 *
 *  @param fadeView 淡化视图
 *  @param duration 动画时长
 */
+ (void)fadeInWithView:(UIView *)fadeView duration:(NSTimeInterval)duration;

/**
 *  交叉淡化动画
 *
 *  @param duration 动画时长
 */
- (void)crossfadeWithDuration:(NSTimeInterval)duration;

/**
 *  交叉淡化动画
 *
 *  @param duration   动画时长
 *  @param completion 动画完成回调
 */
- (void)crossfadeWithDuration:(NSTimeInterval)duration completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
