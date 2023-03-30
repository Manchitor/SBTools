//
//  ERCalendarPickerMonthModel.h
//  ElectricRoom
//
//  Created by 刘永吉 on 2022/6/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ERCalendarPickerMonthModel : NSObject
@property (nonatomic,copy) NSString *dateString;
@property (nonatomic,strong) NSMutableArray *daysArray;

@end

NS_ASSUME_NONNULL_END
