//
//  SBPhotoRevealViewController.h
//  Tools
//
//  Created by 刘永吉 on 2020/9/25.
//  Copyright © 2020 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBPhotoRevealViewController : UIViewController
/**
 *  接收图片数组，数组类型可以是url数组
 */
@property(nonatomic, strong) NSMutableArray *imgArr;

/**
 *  显示下标 (1/10)
 */
@property(nonatomic, strong) UILabel *sliderLabel;
/**
 *  接收当前图片的序号,默认的是0
 */
@property(nonatomic, assign) NSInteger currentIndex;

/**  保存 */
@property(nonatomic,strong)UIButton* saveBtn;
@end

NS_ASSUME_NONNULL_END
