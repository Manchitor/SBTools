//
//  SBBubbleImageView.h
//  Tools
//
//  Created by 刘永吉 on 2023/4/24.
//  Copyright © 2023 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBBubbleImageView : UIView
-(void)startBubbleAnimation:(CGFloat)duration radius:(int)radius;

-(void)stopBubbleAnimation;
@end

NS_ASSUME_NONNULL_END
