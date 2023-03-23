//
//  SBTools+UIImage.h
//  Tools
//
//  Created by 刘永吉 on 2020/9/8.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface SBTools (UIImage)
/**
    修改图片正方向
 */
+(UIImage *)sb_fix_orientation_data:(NSData *)imageData;

+(UIImage *)sb_fix_orientation_image:(UIImage *)image;


/**
    根据图片获取图片的主色调
 */
+ (void )sb_theme_color:(UIImage *)img finish:(void(^)(UIColor *color))callBack;
@end

NS_ASSUME_NONNULL_END
