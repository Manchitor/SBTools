//
//  UITextField+Clear.m
//  
//
//  Created by 刘永吉 on 2020/9/21.
//  Copyright © 2020 rongyiqiche Data and Technology Shanghai Co. Ltd. All rights reserved.
//

#import "UITextField+Clear.h"

@implementation UITextField (Clear)

-(void)setTextFieldClearBtnWhenEditingImage:(UIImage *)image{
    UIButton *clear = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [clear setImage:image forState:UIControlStateNormal];
    [clear setImage:image forState:UIControlStateHighlighted];
    [clear addTarget:self action:@selector(clearTextField) forControlEvents:UIControlEventTouchUpInside];
    self.rightView = clear;
    self.rightViewMode = UITextFieldViewModeWhileEditing;

}

-(void)clearTextField{
    self.text = @"";
}

@end
