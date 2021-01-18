//
//  UIView+Shimmering.m
//  Tools
//
//  Created by 刘永吉 on 2021/1/14.
//  Copyright © 2021 lyj. All rights reserved.
//

#import "UIView+Shimmering.h"
#import <objc/runtime.h>

static NSString * const kshimmeringText = @"shimmeringText";
static NSString * const kshimmeringTextfont = @"shimmeringTextfont";
static NSString * const kshimmeringBackColor = @"shimmeringBackColor";
static NSString * const kshimmeringTextColor = @"shimmeringTextColor";
static NSString * const kshimmeringTextAlignment = @"shimmeringTextAlignment";
static NSString * const kAxcBackLabel = @"BackLabel";
static NSString * const kAxcfrontLabel = @"frontLabel";

@implementation UIView (Shimmering)

- (void)setFrontLabel:(UILabel *)AxcfrontLabel{
    [self willChangeValueForKey:kAxcfrontLabel];
    objc_setAssociatedObject(self, &kAxcfrontLabel,
                             AxcfrontLabel,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kAxcfrontLabel];
}
- (UILabel *)frontLabel{
    UILabel *label = objc_getAssociatedObject(self, &kAxcfrontLabel);
    if (!label) {
        label = [[UILabel alloc] initWithFrame:self.bounds];
        label.numberOfLines = 0;
        [self setFrontLabel:label];
        [self addSubview:label];
    }
    return label;
}

- (void)setBackLabel:(UILabel *)AxcBackLabel{
    [self willChangeValueForKey:kAxcBackLabel];
    objc_setAssociatedObject(self, &kAxcBackLabel,
                             AxcBackLabel,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kAxcBackLabel];
}
- (UILabel *)backLabel{
    UILabel *label = objc_getAssociatedObject(self, &kAxcBackLabel);
    if (!label) {
        label = [[UILabel alloc] initWithFrame:self.bounds];
        label.numberOfLines = 0;
        [self setBackLabel:label];
        [self addSubview:label];
    }
    return label;
}


- (void)setTextAlignment:(NSTextAlignment)shimmeringTextAlignment{
    [self willChangeValueForKey:kshimmeringTextAlignment];
    objc_setAssociatedObject(self, &kshimmeringTextAlignment,
                             @(shimmeringTextAlignment),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kshimmeringTextAlignment];
    self.backLabel.textAlignment = shimmeringTextAlignment;
    self.frontLabel.textAlignment = shimmeringTextAlignment;
}
- (NSTextAlignment)textAlignment{
    return [objc_getAssociatedObject(self, &kshimmeringTextAlignment) intValue];
}

- (void)setTextColor:(UIColor *)textColor{
    [self willChangeValueForKey:kshimmeringTextColor];
    objc_setAssociatedObject(self, &kshimmeringTextColor,
                             textColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kshimmeringTextColor];
    self.frontLabel.textColor = textColor;
}
- (UIColor *)textColor{
    return objc_getAssociatedObject(self, &kshimmeringTextColor);
}

- (void)setText:(NSString *)shimmeringText{
    [self willChangeValueForKey:kshimmeringText];
    objc_setAssociatedObject(self, &kshimmeringText,
                             shimmeringText,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kshimmeringText];
    self.backLabel.text = shimmeringText;
    self.frontLabel.text = shimmeringText;
}
- (NSString *)text{
    return objc_getAssociatedObject(self, &kshimmeringText);
}

- (void)setFont:(UIFont *)shimmeringTextfont{
    [self willChangeValueForKey:kshimmeringTextfont];
    objc_setAssociatedObject(self, &kshimmeringTextfont,
                             shimmeringTextfont,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kshimmeringTextfont];
    self.backLabel.font = shimmeringTextfont;
    self.frontLabel.font = shimmeringTextfont;
}
- (UIFont *)font{
    return objc_getAssociatedObject(self, &kshimmeringTextfont);
}

- (void)setBackColor:(UIColor *)shimmeringBackColor{
    [self willChangeValueForKey:kshimmeringBackColor];
    objc_setAssociatedObject(self, &kshimmeringBackColor,
                             shimmeringBackColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kshimmeringBackColor];
    self.backLabel.textColor = shimmeringBackColor;
}
- (UIColor *)backColor{
    return objc_getAssociatedObject(self, &kshimmeringBackColor);
}


- (void)startShimmeringWithType:(SBShimmeringViewStyle)type Duration:(NSTimeInterval)duration{
    [self.frontLabel.layer.mask removeAllAnimations];
    if (type == SBShimmeringViewStyleOverallFilling) { // 第一个
        [self createFadeRightMask];
        CABasicAnimation *basicAnimation = [CABasicAnimation animation];
        basicAnimation.keyPath = @"transform.translation.x";
        basicAnimation.fromValue = @(0);
        basicAnimation.toValue = @(self.bounds.size.width);
        basicAnimation.duration = duration;
        basicAnimation.repeatCount = LONG_MAX;//循环次数
        basicAnimation.removedOnCompletion = NO;
        basicAnimation.fillMode = kCAFillModeForwards;
        [self.frontLabel.layer.mask addAnimation:basicAnimation forKey:nil];
    }else if(type == SBShimmeringViewStyleFadeLeftToRight){
        [self createiPhoneFadeMask];
        CABasicAnimation *basicAnimation = [CABasicAnimation animation];
        basicAnimation.keyPath = @"transform.translation.x";
        basicAnimation.fromValue = @(0);
        basicAnimation.toValue = @(self.bounds.size.width+self.bounds.size.width/2.0);
        basicAnimation.duration = duration;
        basicAnimation.repeatCount = LONG_MAX;
        basicAnimation.removedOnCompletion = NO;
        basicAnimation.fillMode = kCAFillModeForwards;
        [self.frontLabel.layer.mask addAnimation:basicAnimation forKey:nil];
    }else if(type == SBShimmeringViewStyleFadeRightToLeft){
        [self createiPhoneFadeMask];
        CABasicAnimation *basicAnimation = [CABasicAnimation animation];
        basicAnimation.keyPath = @"transform.translation.x";
        basicAnimation.fromValue = @(self.bounds.size.width+self.bounds.size.width/2.0);;
        basicAnimation.toValue = @(0);
        basicAnimation.duration = duration;
        basicAnimation.repeatCount = LONG_MAX;
        basicAnimation.removedOnCompletion = NO;
        basicAnimation.fillMode = kCAFillModeForwards;
        [self.frontLabel.layer.mask addAnimation:basicAnimation forKey:nil];
    }else if(type == SBShimmeringViewStyleFadeReverse){
        
        [self createiPhoneFadeMask];
        CABasicAnimation *basicAnimation = [CABasicAnimation animation];
        basicAnimation.keyPath = @"transform.translation.x";
        basicAnimation.fromValue = @(0);
        basicAnimation.toValue = @(self.bounds.size.width+self.bounds.size.width/2.0);
        basicAnimation.duration = duration;
        basicAnimation.repeatCount = LONG_MAX;
        basicAnimation.removedOnCompletion = NO;
        basicAnimation.autoreverses = YES;
        basicAnimation.fillMode = kCAFillModeForwards;
        [self.frontLabel.layer.mask addAnimation:basicAnimation forKey:nil];
        
    }else if(type == SBShimmeringViewStyleFadeAll){
        [self createShimmerAllMask];
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        basicAnimation.repeatCount = MAXFLOAT;
        basicAnimation.autoreverses = true;
        basicAnimation.fromValue = @(0.0);
        basicAnimation.toValue = @(1.0);
        basicAnimation.duration = duration;
        
        [self.frontLabel.layer addAnimation:basicAnimation forKey:@"start"];
        [self.frontLabel.layer.mask addAnimation:basicAnimation forKey:nil];
    }
}

- (void)createShimmerAllMask{
    [self.frontLabel.layer removeAllAnimations];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor clearColor].CGColor];
    layer.transform = CATransform3DIdentity;

    self.frontLabel.layer.mask = layer;
}

- (void)createiPhoneFadeMask{
    [self.frontLabel.layer removeAllAnimations];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor clearColor].CGColor];
    layer.locations = @[@(0.25),@(0.5),@(0.75)];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);

    self.frontLabel.layer.mask = layer;
    
    layer.position = CGPointMake(-self.bounds.size.width/4.0, self.bounds.size.height/2.0);
}

- (void)createFadeRightMask{
    [self.frontLabel.layer removeAllAnimations];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor clearColor],(id)[UIColor redColor].CGColor,(id)[UIColor blackColor].CGColor,(id)[UIColor clearColor].CGColor];
    layer.locations = @[@(0.01),@(0.1),@(0.9),@(0.99)];

    self.frontLabel.layer.mask = layer;
}

-(void)stopShimmering{
    [self.frontLabel.layer.mask removeAllAnimations];

}
@end
