//
//  ERCalendarPickerCell.h
//  ElectricRoom
//
//  Created by 刘永吉 on 2022/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^CalendarPickerBlock)(NSDate *date);

@interface ERCalendarPickerCell : UITableViewCell
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,copy) CalendarPickerBlock _Nullable dateBlock;
@end

NS_ASSUME_NONNULL_END
