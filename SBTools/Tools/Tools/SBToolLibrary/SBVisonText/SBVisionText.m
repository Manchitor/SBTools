//
//  SBVisionText.m
//  Tools
//
//  Created by 刘永吉 on 2023/4/19.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBVisionText.h"

@implementation SBVisionText
+ (void)sb_vision_text_image:(UIImage *)img result:(SBVisionTextCallBack) resultBlock{
    
    if (@available(iOS 13.0, *)) {
        VNRecognizeTextRequest *textRequest = [[VNRecognizeTextRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error){
            NSArray *observations = request.results;
            //        [self textRectangles:observations image:image complete:complete];
            NSLog(@"sb_vision_text_image:%@",observations);
            if (resultBlock) {
                resultBlock(error,request.results);
            }
        }];
        textRequest.recognitionLevel = VNRequestTextRecognitionLevelAccurate;
        textRequest.usesLanguageCorrection = NO;
        textRequest.recognitionLanguages = @[@"zh-Hans", @"en-US"];
        
        // 转换CIImage
        CIImage *convertImage = [[CIImage alloc]initWithImage:img];
        
        // 创建处理requestHandler
        VNImageRequestHandler *detectRequestHandler = [[VNImageRequestHandler alloc]initWithCIImage:convertImage options:@{}];
        // 发送识别请求
        [detectRequestHandler performRequests:@[textRequest] error:nil];
    } else {
        // Fallback on earlier versions
        NSLog(@"Fallback on earlier versions");
    }
}
@end
