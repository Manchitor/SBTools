//
//  EdgeLabel.m
//  dyk_cms
//
//  Created by 刘永吉 on 2021/3/29.
//  Copyright © 2021 csh. All rights reserved.
//

#import "EdgeLabel.h"

@implementation EdgeLabel

-(instancetype)init{
    if (self = [super init]) {
        _edgeInsets = UIEdgeInsetsZero;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _edgeInsets = UIEdgeInsetsZero;
    }
    return self;
}
-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    _edgeInsets = edgeInsets;
}
-(void)drawTextInRect:(CGRect)rect{
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsZero)];
}
-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect CGQBZRect =   [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, _edgeInsets) limitedToNumberOfLines:numberOfLines];
    CGQBZRect.origin.x += self.edgeInsets.left;
    CGQBZRect.origin.y += self.edgeInsets.top;
    CGQBZRect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    CGQBZRect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return CGQBZRect;
}

@end
