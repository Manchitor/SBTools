//
//  SBNumberScroller.h
//  Tools
//  数字滚动展示控件
//  Created by 刘永吉 on 2021/1/18.
//  Copyright © 2021 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBNumberScroller : UIControl

#pragma mark ---------内容
///展示的数字
@property (nonatomic, strong) NSNumber *sbNumber;


#pragma mark ---------样式
///颜色
@property (nonatomic, strong) UIColor *sbTextColor;

///字体大小
@property (nonatomic, strong) UIFont *sbFont;

///滚动数字的密度
@property (nonatomic, assign) NSUInteger sbDensity;

///最小显示长度，不够补零
@property (nonatomic, assign) NSUInteger sbMinLength;


#pragma mark ---------动画
///动画总持续时间
@property (nonatomic, assign) NSTimeInterval sbDuration;

///相邻两个数字动画持续时间间隔
@property (nonatomic, assign) NSTimeInterval sbDurationOffset;

///方向，默认为NO，向下
@property (nonatomic, assign) BOOL sbIsAscending;


#pragma mark ---------方法
///刷新
- (void)refresh;


///开始动画
- (void)startAnimation;


///结束动画
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
