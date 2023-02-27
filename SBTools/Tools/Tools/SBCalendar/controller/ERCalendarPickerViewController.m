//
//  ERCalendarPickerViewController.m
//  ElectricRoom
//
//  Created by 刘永吉 on 2022/6/27.
//

#import "ERCalendarPickerViewController.h"
#import "ERCalendarPickerMonthModel.h"
#import "ERCalendarPickerDayModel.h"
#import "ERCalendarPickerCell.h"

#import "SBToolsHeader.h"

@interface ERCalendarPickerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UIView *calendarContent;

@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@property (nonatomic,strong)NSDate *date;


@end

@implementation ERCalendarPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupui];
    
    [self loaddata];
    
    
}

#pragma mark ----------初始化页面UI
-(void)setupui{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    [self.calendarContent addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.calendarContent).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

-(void)loaddata{
    NSInteger months = [self monthsCalculateIntervalStart:self.minDate end:self.maxDate];
    
    for (int index = 0; index < months; index++) {
        //创建数据模型
        ERCalendarPickerMonthModel *model = [[ERCalendarPickerMonthModel alloc] init];
        //获得月份
        NSDate *date = [self dateCalculateIntervalDate:index];
        
        //计算月份标题
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年M月"];
        model.dateString = [dateFormatter stringFromDate:date];
        
        
        //计算月份下的日期数组
        model.daysArray = [self setupMonthsDataDate:date];
        [self.dataArray addObject:model];
    }
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSInteger section = [self monthsCalculateIntervalStart:self.minDate end:[dateFormatter stringFromDate:[NSDate date]]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    });
    
}

- (NSMutableArray *) setupMonthsDataDate:(NSDate *)date{
    //
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    //得到这个月的第一天
    double interval = 0;
    NSDate *beginDate = nil;
    [calendar setFirstWeekday:1];//设定周一为周首日
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:date];
    
    //这个月第一天是星期几
    NSUInteger dayInweek = [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:beginDate] - 1;
    
    //得到这个月的天数
    NSUInteger days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    
    //添加空白
    for (int index = 0; index < (int)dayInweek; index ++) {
        [array addObject:[ERCalendarPickerDayModel new]];
    }
    
    for (int index = 0; index < days; index++) {
        
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        dateComponents.day = +index;
        
        NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:beginDate options:0];
        
        ERCalendarPickerDayModel *model = [[ERCalendarPickerDayModel alloc] init];
        model.date = newDate;
        [array addObject:model];
    }
    return array;
}


- (IBAction)cancelButtonEvent:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)commitButtonEvent:(id)sender {
    if (sb_isEmptyObject(self.date)) {
        return;
    }
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.dateBlock) {
            self.dateBlock(self.date);
        }
    }];
}

#pragma mark ----------TableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ERCalendarPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ERCalendarPickerCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ERCalendarPickerMonthModel *model = self.dataArray[indexPath.section];
    cell.dataArray = model.daysArray;
    SB_WEAKSEKF;
    
    cell.dateBlock = ^(NSDate * _Nonnull date) {
        weakSelf.date = date;
        weakSelf.commitButton.alpha = 1;
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ERCalendarPickerMonthModel *model = self.dataArray[section];
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SB_SCREEN_WIDTH, 30)];
    head.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SB_SCREEN_WIDTH-24, 30)];
    label.text = model.dateString;
    label.textColor = SBCOLORHEX(0x333333,1);
    label.font = SBFONTMEDIUM(15);
    [head addSubview:label];
    return head;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

#pragma mark ----------日历相关计算
- (NSInteger ) monthsCalculateIntervalStart:(NSString *)start end:(NSString *)end{
    //创建两个日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitMonth;
    //比较的结果是NSDateComponents类对象
    NSDateComponents *component = [calendar components:unit fromDate:[dateFormatter dateFromString:start] toDate:[dateFormatter dateFromString:end] options:0];
    
    return component.month;
}

- (NSString *) minDateCalculateInterval{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    dateComponents.month = -3;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

- (NSString *) maxDateCalculateInterval{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    dateComponents.month = +3;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

- (NSDate *) dateCalculateIntervalDate:(NSInteger) section{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    dateComponents.month = +section;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [calendar dateByAddingComponents:dateComponents toDate:[dateFormatter dateFromString:self.minDate] options:0];
    
    return date;
}

#pragma mark ----------懒加载
-(NSString *)minDate{
    if (!_minDate) {
        _minDate = [self minDateCalculateInterval];
    }
    return _minDate;
}

-(NSString *)maxDate{
    if (!_maxDate) {
        _maxDate = [self maxDateCalculateInterval];
    }
    return _maxDate;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = TABLEVIEW_INIT(UITableViewStylePlain, self);
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ERCalendarPickerCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([ERCalendarPickerCell class])];
    }
    return _tableview;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(void)dealloc{
    self.dateBlock = nil;
}
@end
