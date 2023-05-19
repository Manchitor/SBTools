//
//  SBRadarChartViewController.m
//  Tools
//
//  Created by 刘永吉 on 2023/4/23.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBRadarChartViewController.h"

@interface SBRadarChartViewController ()<ChartViewDelegate,IChartAxisValueFormatter>
@property (nonatomic,strong) RadarChartView *radarChartView;
@end

@implementation SBRadarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupui];
    [self setupconfig];
    
    [self setChartData];
}
-(void)setupui{
    [self.view addSubview:self.radarChartView];
    [self.radarChartView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(300, 300));
          make.center.mas_equalTo(self.view);
    }];
}

-(void)setupconfig{
    //1. 设置雷达图线条样式

    //雷达图的线条有两部分构成, 一部分是由中心向外辐射的主干线, 一部分是环绕中心的边线
    self.radarChartView.webLineWidth = 0.5;//主干线线宽
    self.radarChartView.webColor = SBCOLORHEX(0xc2ccd0, 1);//主干线线宽
    self.radarChartView.innerWebLineWidth = 0.375;//边线宽度
    self.radarChartView.innerWebColor = SBCOLORHEX(0xc2ccd0, 1);//边线颜色
    self.radarChartView.webAlpha = 1;//透明度
    
    //2. 设置X轴label样式
    ChartXAxis *xAxis = self.radarChartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:15];//字体
    xAxis.labelTextColor = SBCOLORHEX(0x057748, 1);//颜色

    
    //3. 设置Y轴label样式
    ChartYAxis *yAxis = self.radarChartView.yAxis;
    yAxis.axisMinimum = 0.0;//最小值
    yAxis.axisMaximum = 150;//最大值
    yAxis.drawLabelsEnabled = NO;//是否显示 label
    yAxis.labelCount = 6;// label 个数
    yAxis.labelFont = [UIFont systemFontOfSize:9];// label 字体
    yAxis.labelTextColor = [UIColor lightGrayColor];// label 颜色
    
}

- (void)setChartData
{
    double mult = 80;
    double min = 20;
    int cnt = 5;
    
    NSMutableArray *entries1 = [[NSMutableArray alloc] init];
    NSMutableArray *entries2 = [[NSMutableArray alloc] init];
    
    // NOTE: The order of the entries when being added to the entries array determines their position around the center of the chart.
    for (int i = 0; i < cnt; i++)
    {
        [entries1 addObject:[[RadarChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + min)]];
        [entries2 addObject:[[RadarChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + min)]];
    }
    
    RadarChartDataSet *set1 = [[RadarChartDataSet alloc] initWithEntries:entries1 label:@"Last Week"];
    [set1 setColor:[UIColor colorWithRed:103/255.0 green:110/255.0 blue:129/255.0 alpha:1.0]];
    set1.fillColor = [UIColor colorWithRed:103/255.0 green:110/255.0 blue:129/255.0 alpha:1.0];
    set1.drawFilledEnabled = YES;
    set1.fillAlpha = 0.7;
    set1.lineWidth = 2.0;
    set1.drawHighlightCircleEnabled = YES;
    [set1 setDrawHighlightIndicators:NO];

    RadarChartDataSet *set2 = [[RadarChartDataSet alloc] initWithEntries:entries2 label:@"This Week"];
    [set2 setColor:[UIColor colorWithRed:121/255.0 green:162/255.0 blue:175/255.0 alpha:1.0]];
    set2.fillColor = [UIColor colorWithRed:121/255.0 green:162/255.0 blue:175/255.0 alpha:1.0];
    set2.drawFilledEnabled = YES;
    set2.fillAlpha = 0.7;
    set2.lineWidth = 2.0;
    set2.drawHighlightCircleEnabled = YES;
    [set2 setDrawHighlightIndicators:NO];
    
    RadarChartData *data = [[RadarChartData alloc] initWithDataSets:@[set1, set2]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:8.f]];
    [data setDrawValues:NO];
    data.valueTextColor = UIColor.whiteColor;
    
    _radarChartView.data = data;

}

-(RadarChartView *)radarChartView{
    if (!_radarChartView) {
        _radarChartView = [[RadarChartView alloc] init];
        _radarChartView.backgroundColor = [UIColor whiteColor];
        _radarChartView.xAxis.valueFormatter = self;
        _radarChartView.delegate = self;
        _radarChartView.rotationEnabled = YES;//是否允许转动
        _radarChartView.highlightPerTapEnabled = YES;//是否能被选中
    }
    return _radarChartView;
}

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
//    return @"哈哈";
    NSArray *arr = @[@"哈哈",@"嘿嘿",@"哦哦"];
    int index = (int)value%arr.count;
    return arr[index];
}
-(void)dealloc{
    
}
@end
