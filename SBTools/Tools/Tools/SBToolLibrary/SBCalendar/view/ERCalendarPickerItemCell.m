//
//  ERCalendarPickerItemCell.m
//  ElectricRoom
//
//  Created by 刘永吉 on 2022/6/27.
//

#import "ERCalendarPickerItemCell.h"

@interface ERCalendarPickerItemCell ()
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;

@end
@implementation ERCalendarPickerItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titlelabel.layer.cornerRadius = (SB_SCREEN_WIDTH / 7.f - 8)/2.f;
    self.titlelabel.clipsToBounds = YES;
}

-(void)setModel:(ERCalendarPickerDayModel *)model{
    _model = model;
    
    NSDateFormatter *dateFromatter=[[NSDateFormatter alloc] init];
    [dateFromatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFromatter setDateFormat:@"d"];
    self.titlelabel.text = [dateFromatter stringFromDate:model.date];
    
    self.titlelabel.backgroundColor = model.isSelect ? SBCOLORHEX(0xFDD000,1) : [UIColor clearColor];
    
    if (model.isSelect) {
        self.titlelabel.backgroundColor = SBCOLORHEX(0xFDD000,1);
    }else{
        if ([self compareDate:model.date date:[NSDate date]]) {
            self.titlelabel.backgroundColor = SBCOLORHEX(0xE6EBEE,1);
        }else{
            self.titlelabel.backgroundColor = [UIColor whiteColor];
        }
    }
}

-(BOOL) compareDate:(NSDate *)date date:(NSDate *)other{
    if (!date || !other) {
        return NO;
    }
    
    //先转化为年月日比较 不比较时分秒
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc] init];
    [dateFromatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [dateFromatter stringFromDate:date];
    NSString *otherString = [dateFromatter stringFromDate:other];
    
    
    NSDate *dateCompare = [dateFromatter dateFromString:dateString];
    NSDate *otherCompare = [dateFromatter dateFromString:otherString];

    
    NSComparisonResult result = [dateCompare compare:otherCompare];
    return result == NSOrderedSame;
}
@end
