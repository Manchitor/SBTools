//
//  UILabel+TimerColor.m
//  Tools
//
//  Created by 刘永吉 on 2021/1/13.
//  Copyright © 2021 lyj. All rights reserved.
//

#import "UILabel+TimerColor.h"
#import <objc/runtime.h>

static NSString *timerKey = @"SB_UILabel_Timer";

static NSString *indexKey = @"SB_UILabel_Index";

static NSString *isReSetColorKey = @"SB_UILabel_IsReSetColor";


@interface UILabel (TimerColor)

///逐字定时器循环
@property ( nonatomic , strong ) dispatch_source_t timer;
///逐字变色到达的位置
@property ( nonatomic , assign ) NSInteger index;
///逐字变色后是否复位
@property ( nonatomic , assign ) BOOL isReSetColor;

@end

@implementation UILabel (TimerColor)

- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, &timerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (dispatch_source_t)timer {
    dispatch_source_t timer = objc_getAssociatedObject(self, &timerKey);
    return timer;
}

- (void)setIndex:(NSInteger)index {
    objc_setAssociatedObject(self, &indexKey, @(index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)index {
    NSNumber * number  = objc_getAssociatedObject(self, &indexKey);
    return [number integerValue];
}

- (void)setIsReSetColor:(BOOL)isReSetColor {
    objc_setAssociatedObject(self, &isReSetColorKey, @(isReSetColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isReSetColor {
    NSNumber * number  = objc_getAssociatedObject(self, &isReSetColorKey);
    return [number boolValue];
}

///开启变色动画
-(void)startTimerAnimationTimerDuration:(CGFloat)timerDuration TimerColor:(UIColor *)timerColor isReSetColor:(BOOL)isReSetColor{
    
    if (!self.text.length) {
        return;
    }
    
    self.index = 0;
    
    self.isReSetColor = isReSetColor;

    NSInteger  lenth = self.text.length;
    
    float singleDuration = timerDuration/(float)lenth;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.text];

    //(1)
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //(2)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //(3)
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, singleDuration * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //(4)
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //在这里执行事件
            self.index++;

            if (self.index>lenth) {
                [self stopTimerAnimation];
                return;
            }
            
            [str setAttributes:@{NSForegroundColorAttributeName:timerColor} range:NSMakeRange(0, self.index)];
            [self setAttributedText:str];
            
        });
    });
    //(5)
    dispatch_resume(self.timer);
}

///结束逐字变色动画
-(void)stopTimerAnimation{
    self.index = 0;
    
    if (self.isReSetColor) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.text];

        [str setAttributes:@{NSForegroundColorAttributeName:self.textColor} range:NSMakeRange(0, self.index)];
        
        [self setAttributedText:str];
    }

    dispatch_cancel(self.timer);
}

-(void)startFlashingAnimation{
    self.backgroundColor = [UIColor clearColor];
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = self.bounds;
    CGFloat gradientSize = self.frame.size.width /6 / self.frame.size.width;
    UIColor *gradient = [UIColor colorWithWhite:1.0f alpha:0.4];
    NSArray *startLocations = @[[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:(gradientSize / 2)], [NSNumber numberWithFloat:gradientSize]];
    NSArray *endLocations = @[[NSNumber numberWithFloat:(1.0f - gradientSize)], [NSNumber numberWithFloat:(1.0f -(gradientSize / 2))], [NSNumber numberWithFloat:1.0f]];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    
    gradientMask.colors = @[(id)gradient.CGColor, (id)[UIColor whiteColor].CGColor, (id)gradient.CGColor];
    gradientMask.locations = startLocations;
    gradientMask.startPoint = CGPointMake(0 - (gradientSize * 2), .5);
    gradientMask.endPoint = CGPointMake(1 + gradientSize, .5);
    
    self.layer.mask = gradientMask;
    
    animation.fromValue = startLocations;
    animation.toValue = endLocations;
    animation.repeatCount = INFINITY;
    animation.duration  = 0.007*[UIScreen mainScreen].bounds.size.width/2.8;
    
    [gradientMask addAnimation:animation forKey:nil];
}
@end
