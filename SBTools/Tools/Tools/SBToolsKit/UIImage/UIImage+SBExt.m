//
//  UIImage+SBExt.m
//  Tools
//
//  Created by 刘永吉 on 2020/9/8.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "UIImage+SBExt.h"


@implementation UIImage (SBExt)

/**
 *  根据颜色来设置image
 *
 *  @param color 颜色
 *
 *  @return 设置好的image
 */
+ (UIImage *)sb_image_create_color:(UIColor *)color{
    return [[self class] sb_image_create_color:color size:CGSizeMake(1, 1)];
}

/**
 *  根据颜色和尺寸返回
 *
 *  @param color 颜色
 *  @param size  image的尺寸
 *
 *  @return 设置好的image
 */
+ (UIImage *)sb_image_create_color:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
        
    return image;
}


/**
 *  添加高斯效果
 *
 */
- (UIImage *)sb_image_apply_effect_blur:(CGFloat )blur{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage  *inputImage=[CIImage imageWithCGImage:self.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}


/**
 *  截图生成图片。
 *  @param  view  UIView及其子类。
 *  @param  scale 屏幕放大倍数，1为原尺寸。
 *  return  抓取图片后的Image。
 */
+ (UIImage *)sb_image_capture_view:(UIView *)view scale:(CGFloat)scale{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
