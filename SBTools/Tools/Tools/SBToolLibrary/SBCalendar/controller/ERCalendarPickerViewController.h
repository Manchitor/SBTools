//
//  ERCalendarPickerViewController.h
//  ElectricRoom
//
//  Created by 刘永吉 on 2022/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^PickerCalendarDateBlock)(NSDate *date);

@interface ERCalendarPickerViewController : UIViewController

@property (nonatomic,strong) NSString *minDate;

@property (nonatomic,strong) NSString *maxDate;

@property (nonatomic,copy) PickerCalendarDateBlock _Nullable dateBlock;

@end

NS_ASSUME_NONNULL_END
