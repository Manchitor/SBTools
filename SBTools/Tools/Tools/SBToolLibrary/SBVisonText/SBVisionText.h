//
//  SBVisionText.h
//  Tools
//
//  Created by 刘永吉 on 2023/4/19.
//  Copyright © 2023 lyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Vision/Vision.h>

NS_ASSUME_NONNULL_BEGIN
API_AVAILABLE(ios(11.0))
typedef void(^SBVisionTextCallBack)(NSError *error, NSArray<__kindof VNObservation*>* results);

API_AVAILABLE(ios(11.0))
@interface SBVisionText : NSObject

@property (nonatomic,copy)SBVisionTextCallBack resultBlock;

+ (void)sb_vision_text_image:(UIImage *)img result:(SBVisionTextCallBack) resultBlock;
@end

NS_ASSUME_NONNULL_END
