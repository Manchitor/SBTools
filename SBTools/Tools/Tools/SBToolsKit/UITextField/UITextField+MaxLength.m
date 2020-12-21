//
//  UITextField+MaxLength.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/19.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "UITextField+MaxLength.h"
#import <objc/runtime.h>

static NSString *kMaxLengthKey = @"SB_UITextField_MaxLength";


@implementation UITextField (MaxLength)
- (void)setMaxLenght:(NSInteger)maxLenght {
    objc_setAssociatedObject(self, &kMaxLengthKey, @(maxLenght), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)maxLenght {
    NSNumber * number = objc_getAssociatedObject(self, &kMaxLengthKey);
    return  [number integerValue];
}
+ (void)load {
    //使用Xib，StoryBoard创建的UITextField
    Method  method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method  method2 = class_getInstanceMethod([self class], @selector(AdapterinitWithCoder:));
    
    //使用initWithFrame创建的UITextField
    Method method3 = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method method4 = class_getInstanceMethod([self class], @selector(AdapterinitWithFrame:));
    method_exchangeImplementations(method1, method2);
    
    method_exchangeImplementations(method3, method4);

}

- (instancetype)AdapterinitWithFrame:(CGRect)frame {
    [self AdapterinitWithFrame:frame];
    if (self) {
        //注册观察UITextField输入变化的方法。
        [self addLengthObserverEvent];
    }
    return self;
}


- (instancetype)AdapterinitWithCoder:(NSCoder *)aDecoder {
    [self AdapterinitWithCoder:aDecoder];
    if (self) {
        [self addLengthObserverEvent];
    }
    return self;
}
- (void)addLengthObserverEvent {
    [self addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)valueChange {
    if (self.maxLenght > 0 && self.text.length > self.maxLenght) {
        self.text = [self.text substringToIndex:self.maxLenght];
    }
}
@end
