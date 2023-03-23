//
//  SBCustomerTextView.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/7.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBCustomerTextView.h"
#define SBDarkMode @available(iOS 13.0, *) && UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark

@interface SBCustomerTextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, copy) SBCustomerTextViewBlock _Nullable changeHandler; ///< 文本改变Block

@property (nonatomic, copy) SBCustomerTextViewBlock _Nullable maxHandler; ///< 达到最大限制字符数Block

@end

@implementation SBCustomerTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] != NSOrderedAscending) {
        
        [self layoutIfNeeded];
    }
    
    [self initialize];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    [self initialize];
    
    return self;
}
- (BOOL)becomeFirstResponder{
    BOOL become = [super becomeFirstResponder];
    
    // 成为第一响应者时注册通知监听文本变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    
    return become;
}

- (BOOL)resignFirstResponder{
    BOOL resign = [super resignFirstResponder];
    
    // 注销第一响应者时移除文本变化的通知, 以免影响其它的`UITextView`对象.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    
    return resign;
}
#pragma mark ----------初始化
- (void)initialize{
    if (_maxLength == 0 || _maxLength == NSNotFound) {//默认无限的字数限制
        _maxLength = NSUIntegerMax;
    }
    // 基本设定 (需判断是否在Storyboard中设置了值)
    if (!self.backgroundColor) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    if (!self.font) {
        
        self.font = [UIFont systemFontOfSize:15.f];
    }
    
    // placeholderLabel
    self.placeholderLabel.font = self.font;
    
    self.placeholderLabel.text = _placeholder; // 可能在Storyboard中设置了Placeholder
    
    if (@available(iOS 13.0, *)) {//iOS 13 动态颜色 暗黑模式的placeholderTextColor
        
        //1.如果你的项目做了iOS 13.0 的暗黑模式适配  则不需要手动更改placeholderColor
        //[UIColor placeholderTextColor] 是动态的颜色 会自动变化
        //self.placeholderLabel.textColor = [UIColor placeholderTextColor];//(这里先注视 有需要再打开)

        //2.如果你的项目没有做iOS 13.0 的暗黑模式适配  则需要手动更改placeholderColor
        //否则placeholder 颜色会变得非常浅 看不清 [UIColor placeholderTextColor] 是动态的颜色
        self.placeholderLabel.textColor = [UIColor colorWithRed:0.780 green:0.780 blue:0.804 alpha:1.000];
        
    } else {
        // Fallback on earlier versions
        self.placeholderLabel.textColor = [UIColor colorWithRed:0.780 green:0.780 blue:0.804 alpha:1.000];
    }
    [self addSubview:self.placeholderLabel];
    
    // constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:8.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:6.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.0
                                                      constant:-6.0*2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.placeholderLabel
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:-8.0*2]];
}
#pragma mark ---------- NSNotification
- (void)textDidChange:(NSNotification *)notification{
    // 通知回调的实例的不是当前实例的话直接返回
    if (notification.object != self) return;
    
    // 根据字符数量显示或者隐藏 `placeholderLabel`
    self.placeholderLabel.hidden = [@(self.text.length) boolValue];
    
    
    // 只有当maxLength字段的值不为无穷大整型也不为0时才计算限制字符数.
    if (_maxLength != NSUIntegerMax && _maxLength != 0 && self.text.length > 0) {
        
        if (!self.markedTextRange && self.text.length > _maxLength) {
            
            !_maxHandler ?: _maxHandler(self); // 回调达到最大限制的Block.
            
            self.text = [self.text substringToIndex:_maxLength]; // 截取最大限制字符数.
            
            [self.undoManager removeAllActions]; // 达到最大字符数后清空所有 undoaction, 以免 undo 操作造成crash.
        }
    }
    
    // 回调文本改变的Block.
    !_changeHandler ?: _changeHandler(self);
}

- (void)addTextDidChangeHandler:(SBCustomerTextViewBlock)changeHandler{
    
    _changeHandler = [changeHandler copy];
    
}

- (void)addTextLengthDidMaxHandler:(SBCustomerTextViewBlock)maxHandler{
    
    _maxHandler = [maxHandler copy];
    
}

- (void)setPlaceholder:(NSString *)placeholder{
    
    if (!placeholder) return;
    
    _placeholder = [placeholder copy];
    
    if (_placeholder.length > 0) {
        
        self.placeholderLabel.text = _placeholder;
    }
    
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    if (!placeholderColor) return;
    
    _placeholderColor = [placeholderColor copy];
    
    self.placeholderLabel.textColor = placeholderColor;

}
#pragma mark ----------懒加载
- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        
        _placeholderLabel = [[UILabel alloc] init];
        
        _placeholderLabel.numberOfLines = 0;
        
        _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    
    return _placeholderLabel;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _changeHandler = nil;
    
    _maxHandler = nil;
}
@end
