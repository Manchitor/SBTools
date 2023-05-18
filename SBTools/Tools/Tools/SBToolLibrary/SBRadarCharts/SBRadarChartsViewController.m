//
//  SBRadarChartsViewController.m
//  Tools
//
//  Created by 刘永吉 on 2023/5/9.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBRadarChartsViewController.h"
#import "SBRadarCharts.h"

@interface SBRadarChartsViewController ()
@property (nonatomic,strong) SBRadarCharts * ber;
@end

@implementation SBRadarChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.ber = [[SBRadarCharts alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 300)/2.0, 100, 300, 300)];
    
    self.ber.backgroundColor = [UIColor whiteColor];
//    ber.header_image = [UIImage imageNamed:@"HEAL.jpg"];
    self.ber.imgWidth = 0;
    self.ber.values = @[@"40",@"50",@"80",@"50",@"90",@"50",@"70",@"90",@"30"];
    self.ber.titles = @[@"阴虚",@"痰湿",@"温热",@"血瘀",@"气郁",@"特禀",@"平和",@"气虚",@"阳虚"];
    [self.view addSubview:self.ber];


}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.ber.themColor = [UIColor redColor];
    [self.ber setNeedsDisplay];
}

@end
