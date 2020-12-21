//
//  UIView+CornerRadius.h
//  Tools
//
//  Created by 刘永吉 on 2020/9/22.
//  Copyright © 2020 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>
//账号权限-app的权限
typedef NS_ENUM(NSInteger,SBToolCornerRadiusType) {
    SBToolCornerRadiusTypeLeft                              = 0,//左边圆角
    SBToolCornerRadiusTypeRight                             = 1,//右边圆角
    SBToolCornerRadiusTypeUp                                = 2,//上面圆角
    SBToolCornerRadiusTypeDown                              = 3,//下面圆角
    SBToolCornerRadiusTypeDefault                           = 4//全角
};
NS_ASSUME_NONNULL_BEGIN

@interface UIView (CornerRadius)
/**
 圆角样式
 圆角大小
 bounds   （宽高）便于画线
 此方法需要先确定控件bouns
 */
- (void)roundSideCornerRadius:(SBToolCornerRadiusType)side cornerRadius:(CGFloat)cornerRadius  Bounds:(CGRect)bounds;
@end

NS_ASSUME_NONNULL_END
