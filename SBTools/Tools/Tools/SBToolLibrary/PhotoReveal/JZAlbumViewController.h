//
//  JZAlbumViewController.h
//  aoyouHH
//  功能描述：用于显示并浏览图片，添加了加载进度条功能
//  Created by lyj on 15/4/27.
//  Copyright (c) 2015年 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZAlbumViewController : UIViewController

/**
 *  接收图片数组，数组类型可以是url数组
 */
@property(nonatomic, strong) NSMutableArray *imgArr;

/**
 *  显示scrollView
 */
@property(nonatomic, strong) UIScrollView *scrollView;
/**
 *  显示下标
 */
@property(nonatomic, strong) UILabel *sliderLabel;
/**
 *  接收当前图片的序号,默认的是0
 */
@property(nonatomic, assign) NSInteger currentIndex;

/**  保存 */
@property(nonatomic,strong)UIButton* saveBtn;

@end
