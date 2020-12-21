//
//  SBCustomerTextView.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/7.
//  Copyright © 2020 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SBCustomerTextView;

typedef void(^SBCustomerTextViewBlock)(SBCustomerTextView *textView);

IB_DESIGNABLE
@interface SBCustomerTextView : UITextView

/**
    placeholder 会自适应TextView宽高以及横竖屏切换, 字体默认和TextView一致.
*/
@property (nonatomic,copy) IBInspectable NSString *placeholder;

/**
    placeholderColor
*/
@property (nonatomic,copy) IBInspectable UIColor *placeholderColor;
/**
    最大限制文本长度, 默认为无穷大, 即不限制, 如果被设为 0 也同样表示不限制字符数.
 */
@property (nonatomic, assign) IBInspectable NSUInteger maxLength;


/**
 设定文本改变Block回调. (切记弱化引用, 以免造成内存泄露.)
 */
- (void)addTextDidChangeHandler:(SBCustomerTextViewBlock)eventHandler;


/**
 设定达到最大长度Block回调. (切记弱化引用, 以免造成内存泄露.)
 */
- (void)addTextLengthDidMaxHandler:(SBCustomerTextViewBlock)maxHandler;
@end

NS_ASSUME_NONNULL_END
