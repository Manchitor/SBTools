//
//  UIView+CornerRadius.m
//  Tools
//
//  Created by 刘永吉 on 2020/9/22.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)
- (void)roundSideCornerRadius:(SBToolCornerRadiusType)side cornerRadius:(CGFloat)cornerRadius  Bounds:(CGRect)bounds
{
    if (side == SBToolCornerRadiusTypeDefault) {
        self.layer.cornerRadius = cornerRadius;
        self.clipsToBounds = YES;
        return;
    }
    UIBezierPath *maskPath;
    
    if (side == SBToolCornerRadiusTypeLeft){
        maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
              cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    }else if (side == SBToolCornerRadiusTypeRight){
        maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
        byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
              cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    }else if (side == SBToolCornerRadiusTypeUp){
        maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
        byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
              cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    }else
        maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                         byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                               cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    self.layer.mask = maskLayer;
    
    [self.layer setMasksToBounds:YES];
}
@end
