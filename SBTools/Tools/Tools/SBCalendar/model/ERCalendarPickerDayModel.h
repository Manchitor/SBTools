//
//  ERCalendarPickerDayModel.h
//  ElectricRoom
//
//  Created by 刘永吉 on 2022/6/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ERCalendarPickerDayModel : NSObject

@property (nonatomic,assign) BOOL isSelect;

@property (nonatomic,strong) NSDate *date;

@end

NS_ASSUME_NONNULL_END
