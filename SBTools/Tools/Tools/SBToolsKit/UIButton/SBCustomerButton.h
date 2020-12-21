//
//  SBCustomerButton.h
//  Tools
//
//  Created by 刘永吉 on 2020/8/6.
//  Copyright © 2020 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum{
    /**
        默认状态-->图片在左 文字在右 居中
     */
    SBCustomerButtonStyleNormal,//
    /**
        自定义状态-->文字在左 图片在右 左对齐
     */
    SBCustomerButtonStyleLeft,
    /**
       自定义状态-->文字在左 图片在右 居中对齐
    */
    SBCustomerButtonStyleCenter,
    /**
       自定义状态-->文字在左 图片在右 右对齐
    */
    SBCustomerButtonStyleRight,
    /**
       自定义状态-->图标在上，文本在下(居中)
    */
    SBCustomerButtonStyleTop,
    /**
       自定义状态-->图标在下，文本在上(居中)
    */
    SBCustomerButtonStyleBottom
    
}SBCustomerButtonStyle;

@interface SBCustomerButton : UIButton
/**
 *  外界通过设置按钮的Style属性，创建不同类型的按钮
 */
@property (nonatomic,assign)SBCustomerButtonStyle style;

- (instancetype)initWithAlignmentStyle:(SBCustomerButtonStyle)style;

@end

NS_ASSUME_NONNULL_END
