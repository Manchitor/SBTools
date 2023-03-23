//
//  SBEdgeLabel.m
//  Tools
//
//  Created by 刘永吉 on 2023/3/23.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBEdgeLabel.h"

@implementation SBEdgeLabel

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
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
