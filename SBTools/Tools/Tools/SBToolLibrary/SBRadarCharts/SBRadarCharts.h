//
//  SBRadarCharts.h
//  Tools
//
//  Created by 刘永吉 on 2023/5/9.
//  Copyright © 2023 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBRadarCharts : UIView

/** 中心点图片 */
@property (nonatomic,strong) UIImage *img;
/** 数据源数组 */
@property (nonatomic,strong) NSArray *values;
/** 数据元素的名称 */
@property (nonatomic,strong) NSArray *titles;
/** 圆半径 */
@property (nonatomic,assign) CGFloat radius;
/** 中心点图片半径边框的宽度 */
@property (nonatomic,assign) CGFloat imgBoderWidth;
/** 中心点图片的宽度 */
@property (nonatomic,assign) CGFloat imgWidth;
/** 小白点 */
@property (nonatomic,assign) CGFloat dioWdith;
/** 小白点边框的宽度  */
@property (nonatomic,assign) CGFloat dioBoderWdith;

/** label的宽度 */
@property (nonatomic,assign) CGFloat labelWidth;
/** label的宽度 */
@property (nonatomic,assign) CGFloat labelHeight;

/** 图层的颜色 */
@property (nonatomic,strong) UIColor *themColor;
/** 圆环的颜色 */
@property (nonatomic,strong) UIColor *cirlColor;
/** 圆环之间的间距 */
@property (nonatomic,assign) CGFloat cirlMargin;

/** 小图层减少大图层值得比例 百分比 proportion*radius*/
@property (nonatomic,assign) CGFloat proportion;
@end

NS_ASSUME_NONNULL_END
