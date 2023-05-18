//
//  SBBubbleImageView.m
//  Tools
//
//  Created by 刘永吉 on 2023/4/24.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBBubbleImageView.h"

@interface SBBubbleImageView ()

@property (nonatomic,strong) CAKeyframeAnimation *animation;
@property (nonatomic,assign) CGMutablePathRef path;

@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,assign) int radius;

@end

@implementation SBBubbleImageView

-(void)startBubbleAnimation:(CGFloat)duration radius:(int)radius{
    _duration = duration;
    _radius = radius;
    
    [self.layer removeAllAnimations];
    [self.layer addAnimation:self.animation forKey:@""];
}

-(void)stopBubbleAnimation{
    [self.layer removeAllAnimations];
    _animation = nil;
    _path = nil;
}


-(CAKeyframeAnimation *)animation{
    if (!_animation) {
        _animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        _animation.duration = self.duration;
        _animation.repeatCount = HUGE_VALF;//无穷大
        _animation.additive = YES;//原来的基础上添加动画
        _animation.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
        _animation.removedOnCompletion = YES;//移除指针
        _animation.timeOffset = 0.0f;
        _animation.path = self.path;
    }
    return _animation;
}

-(CGMutablePathRef)path{
    if (!_path) {
        _path = CGPathCreateMutable();
        CGPathMoveToPoint(_path, NULL, -arc4random()%self.radius, 0);
        CGPathAddLineToPoint(_path, NULL, 0, arc4random()%self.radius);
        CGPathAddLineToPoint(_path, NULL, arc4random()%self.radius, -arc4random()%self.radius);
        CGPathAddLineToPoint(_path, NULL, arc4random()%self.radius, 0);
        CGPathAddLineToPoint(_path, NULL, arc4random()%self.radius, arc4random()%self.radius);
        CGPathAddLineToPoint(_path, NULL, 0, arc4random()%self.radius);
        CGPathAddLineToPoint(_path, NULL, -arc4random()%self.radius, -arc4random()%self.radius);
        CGPathCloseSubpath(_path);
    }
    
    return _path;
}



@end
