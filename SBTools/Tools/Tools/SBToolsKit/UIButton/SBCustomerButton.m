//
//  SBCustomerButton.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/6.
//  Copyright © 2020 lyj. All rights reserved.
//


#import "SBCustomerButton.h"

#define sb_margin 5

//    获得按钮的大小
#define sb_btnWidth self.bounds.size.width
#define sb_btnHeight self.bounds.size.height

//    获得按钮中UILabel文本的大小
#define sb_labelWidth self.titleLabel.bounds.size.width
#define sb_labelHeight self.titleLabel.bounds.size.height

//    获得按钮中image图标的大小
#define sb_imageWidth self.imageView.bounds.size.width
#define sb_imageHeight self.imageView.bounds.size.height

@implementation SBCustomerButton

- (instancetype)initWithAlignmentStyle:(SBCustomerButtonStyle)style{
    SBCustomerButton *button = [[SBCustomerButton alloc] init];
    button.style = style;
    return button;
}
-(void)setStyle:(SBCustomerButtonStyle)style{
    _style = style;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    // 判断样式
   if (self.style == SBCustomerButtonStyleNormal) {
       
   }else if (self.style == SBCustomerButtonStyleLeft){
       [self customerLeftStyleModifyFrame];
   }else if (self.style == SBCustomerButtonStyleCenter){
       [self customerCenterStyleModifyFrame];
   }else if (self.style == SBCustomerButtonStyleRight){
       [self customerRightStyleModifyFrame];
   }else if (self.style == SBCustomerButtonStyleTop){
       [self customerTopStyleModifyFrame];
   }else if (self.style == SBCustomerButtonStyleBottom){
       [self customerBottomStyleModifyFrame];
   }
}
#pragma mark ----------各式样式布局 为了美化 文字和图片中间有sb_margin 间隙 可跟实际情况自定义 sb_margin
-(void)customerLeftStyleModifyFrame{
    //    获得按钮的文本的frame
       CGRect titleFrame = self.titleLabel.frame;
       //    设置按钮的文本的x坐标为0+sb_margin -－－左对齐
    
       titleFrame.origin.x = 0+sb_margin;
    
       //    获得按钮的图片的frame
       CGRect imageFrame = self.imageView.frame;
    
       //    设置按钮的图片的x坐标紧跟文本的后面
       imageFrame.origin.x = CGRectGetMaxX(titleFrame)+sb_margin;
    
       //    重写赋值frame
       self.titleLabel.frame = titleFrame;
    
       self.imageView.frame = imageFrame;
}
-(void)customerCenterStyleModifyFrame{
    //    设置文本的坐标
       CGFloat labelX = (sb_btnWidth - sb_labelWidth -sb_imageWidth - sb_margin) * 0.5;
    
       CGFloat labelY = (sb_btnHeight - sb_labelHeight) * 0.5;
       
       //    设置label的frame
       self.titleLabel.frame = CGRectMake(labelX, labelY, sb_labelWidth, sb_labelHeight);
       
       //    设置图片的坐标
       CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame) + sb_margin;
    
       CGFloat imageY = (sb_btnHeight - sb_imageHeight) * 0.5;
       //    设置图片的frame
       self.imageView.frame = CGRectMake(imageX, imageY, sb_imageWidth, sb_imageHeight);
}
- (void)customerRightStyleModifyFrame{
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.x = self.bounds.size.width - sb_imageWidth-sb_margin;
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = imageFrame.origin.x - frame.size.width -sb_margin;
    //    重写赋值frame
    self.titleLabel.frame = titleFrame;
    
    self.imageView.frame = imageFrame;
}

- (void)customerTopStyleModifyFrame{

    CGFloat imageX = (sb_btnWidth - sb_imageWidth) * 0.5;
    
    //计算两个控件高度和并加上两个控件的间隙 算出距离button上下的间隙
    CGFloat topMargin = (sb_btnHeight-sb_imageHeight-sb_labelHeight-sb_margin)*0.5;
    
    if (topMargin < 0) {
        NSLog(@"SBCustomerButton:-->请注意你的按钮高度,不够大啊...");
    }
    
    self.imageView.frame = CGRectMake(imageX, topMargin, sb_imageWidth, sb_imageHeight);
    
    self.titleLabel.frame = CGRectMake((sb_btnWidth - sb_labelWidth) * 0.5, CGRectGetMaxY(self.imageView.frame)+sb_margin, sb_labelWidth, sb_labelHeight);

}

- (void)customerBottomStyleModifyFrame{
    //计算两个控件高度和并加上两个控件的间隙 算出距离button上下的间隙
    CGFloat topMargin = (sb_btnHeight-sb_imageHeight-sb_labelHeight-sb_margin)*0.5;
    
    if (topMargin < 0) {
        NSLog(@"SBCustomerButton:-->请注意你的按钮高度,不够大啊...");
    }
    
    self.titleLabel.frame = CGRectMake((sb_btnWidth-sb_labelWidth)*0.5, topMargin, sb_labelWidth, sb_labelHeight);
    
    self.imageView.frame = CGRectMake((sb_btnWidth-sb_imageWidth)*0.5, CGRectGetMaxY(self.titleLabel.frame)+sb_margin , sb_imageWidth, sb_imageHeight);
}
@end
