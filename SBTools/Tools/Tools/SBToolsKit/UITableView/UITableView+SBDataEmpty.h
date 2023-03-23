//
//  UITableView+SBDataEmpty.h
//  Tools
//
//  Created by 刘永吉 on 2020/12/22.
//  Copyright © 2020 lyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SBDataEmpty)

- (void) sb_data_empty_count: (NSInteger) rowCount showMessage: (NSString *) showMessage imageName: (NSString *) imageName;
@end

NS_ASSUME_NONNULL_END
