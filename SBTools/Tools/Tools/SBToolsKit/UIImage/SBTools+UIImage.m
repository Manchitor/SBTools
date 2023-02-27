//
//  SBTools+UIImage.m
//  Tools
//
//  Created by 刘永吉 on 2020/9/8.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools+UIImage.h"

@implementation SBTools (UIImage)
/**
    修改图片正方向
 */
+(UIImage *)SB_fixOrientationWithImageData:(NSData *)imageData{
    UIImage* image = [UIImage imageWithData:imageData];
   return [SBTools SB_fixOrientationWithImage:image];
}

+(UIImage *)SB_fixOrientationWithImage:(UIImage *)image{
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp)
        return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//根据图片获取图片的主色调
+ (void)SB_getImageThemeColor:(UIImage *)img finish:(void(^)(UIColor * color))callBack {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
        int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
        CGSize thumbSize = CGSizeMake(40, 40);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(NULL,thumbSize.width,thumbSize.height, 8, thumbSize.width*4, colorSpace,bitmapInfo);
        CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
        CGContextDrawImage(context, drawRect, img.CGImage);
        CGColorSpaceRelease(colorSpace);
        
        // 第二步 取每个点的像素值
        unsigned char* data = CGBitmapContextGetData (context);
        if (data == NULL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callBack(nil);
            });
        };
        NSCountedSet* cls = [NSCountedSet setWithCapacity: thumbSize.width * thumbSize.height];
        for (int x = 0; x < thumbSize.width; x++) {
            for (int y = 0; y < thumbSize.height; y++) {
                int offset = 4 * (x * y);
                int red = data[offset];
                int green = data[offset + 1];
                int blue = data[offset + 2];
                int alpha =  data[offset + 3];
                // 过滤透明的、基本白色、基本黑色
                if (alpha > 0 && (red < 250 && green < 250 && blue < 250) && (red > 5 && green > 5 && blue > 5)) {
                    NSArray *clr = @[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
            }
        }
        CGContextRelease(context);
        
        //第三步 找到出现次数最多的那个颜色
        NSEnumerator *enumerator = [cls objectEnumerator];
        NSArray *curColor = nil;
        NSArray *MaxColor = nil;
        NSUInteger MaxCount = 0;
        while ((curColor = [enumerator nextObject]) != nil){
            NSUInteger tmpCount = [cls countForObject:curColor];
            if ( tmpCount < MaxCount ) continue;
            MaxCount = tmpCount;
            MaxColor = curColor;
        }
        UIColor * subjectColor = [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack(subjectColor);
        });
    });
}

@end
