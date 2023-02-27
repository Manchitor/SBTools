//
//  ERCalendarPickerItemCell.h
//  ElectricRoom
//
//  Created by 刘永吉 on 2022/6/27.
//

#import <UIKit/UIKit.h>
#import "ERCalendarPickerDayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ERCalendarPickerItemCell : UICollectionViewCell
@property (nonatomic,strong) ERCalendarPickerDayModel *model;
@end

NS_ASSUME_NONNULL_END
