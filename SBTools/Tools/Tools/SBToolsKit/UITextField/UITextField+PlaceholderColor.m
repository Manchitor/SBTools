//
//  UITextField+PlaceholderColor.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/19.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "UITextField+PlaceholderColor.h"

@implementation UITextField (PlaceholderColor)

/**
 *  Xib 中的UITextField 的placeholderColor 设置
 *  如果项目没有做暗黑模式的适配所以全局设置xib中PlaceholderColor 颜色
 */
-(void)awakeFromNib{
    [super awakeFromNib];
    if (@available(iOS 13.0, *)) {//iOS 13 动态颜色 暗黑模式的placeholderTextColor
        
        //1.如果你的项目做了iOS 13.0 的暗黑模式适配  则不需要手动更改placeholderColor
        //[UIColor placeholderTextColor] 是动态的颜色 会自动变化
        //[self setPlaceholderColor:[UIColor placeholderTextColor]];//(这里先注视 有需要再打开)

        //2.如果你的项目没有做iOS 13.0 的暗黑模式适配  则需要手动更改placeholderColor
        //否则placeholder 颜色会变得非常浅 如下设置即可
        [self setPlaceholderColor:[UIColor colorWithRed:0.780 green:0.780 blue:0.804 alpha:1.000]];

       } else {
           // Fallback on earlier versions
           [self setPlaceholderColor:[UIColor colorWithRed:0.780 green:0.780 blue:0.804 alpha:1.000]];
       }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    if (@available(iOS 13.0, *)) {
        
        self.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{
            NSForegroundColorAttributeName : placeholderColor
        }];
        
    } else {
        [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    if (@available(iOS 13.0, *)) {
        self.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{
            NSFontAttributeName : placeholderFont
        }];
    } else {
        [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
    }
}

- (void) setPlaceholderColor:(UIColor *)placeholderColor
             placeholderFont:(UIFont *)placeholderFont {
    if (@available(iOS 13.0, *)) {
        self.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{
            NSForegroundColorAttributeName : placeholderColor,
            NSFontAttributeName : placeholderFont
        }];
        
    } else {
        [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
    }
}
@end
