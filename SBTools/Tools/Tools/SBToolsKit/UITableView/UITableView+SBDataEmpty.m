//
//  UITableView+SBDataEmpty.m
//  Tools
//
//  Created by 刘永吉 on 2020/12/22.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "UITableView+SBDataEmpty.h"

@implementation UITableView (SBDataEmpty)

- (void) sb_data_empty_count: (NSInteger) rowCount showMessage: (NSString *) showMessage imageName: (NSString *) imageName {
    
    if (rowCount == 0) {
        
        UIView *backV = (UIView *)[[NSBundle mainBundle] loadNibNamed:@"SBDataEmpty" owner:nil options:nil].firstObject;
        if (showMessage != nil) {
            for (UIView *view in backV.subviews) {
                if ([view isKindOfClass:[UILabel class]]) {
                    UILabel *lab = (UILabel *)view;
                    lab.text = showMessage;
                    break;
                }
            }
        }
        if (imageName != nil) {
            for (UIView *view in backV.subviews) {
                if ([view isKindOfClass:[UIImageView class]]) {
                    UIImageView *imgView = (UIImageView *)view;
                    imgView.contentMode = UIViewContentModeCenter;
                    imgView.image = [UIImage imageNamed:imageName];
                    break;
                }
            }
        }
        self.backgroundView = backV;
    } else {
        self.backgroundView = nil;
    }
}
@end
