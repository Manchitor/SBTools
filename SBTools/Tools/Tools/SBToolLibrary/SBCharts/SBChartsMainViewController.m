//
//  SBChartsMainViewController.m
//  Tools
//
//  Created by 刘永吉 on 2023/4/20.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBChartsMainViewController.h"
#import "MainCustomCell.h"
#import "SBLineChartViewController.h"
#import "SBBarChartViewController.h"
#import "SBPieChartViewController.h"
#import "SBBubbleChartViewController.h"
#import "SBRadarChartViewController.h"


@interface SBChartsMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;

@property (nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation SBChartsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupconfig];//初始化页面配置
    
    [self setupui];//初始化UI
    
    [self loaddata];//请求数据
    
}

#pragma mark ----------初始化页面配置
-(void)setupconfig{
    self.navigationItem.title = @"SBTool示例";
    
    self.view.backgroundColor = SBCOLORHEX(0xf8f8f8, 1);
    
}

#pragma mark ----------初始化页面
-(void)setupui{
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(0);
        make.left.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideBottom).offset(0);
    }];
    //底线上面 mas_bottomLayoutGuideTop
}

#pragma mark ----------初始化数据
-(void)loaddata{
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"Line Chart" ExampleDesc:@"A simple demonstration of the linechart."]];
    
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"Bar Chart" ExampleDesc:@"A simple demonstration of the bar chart."]];
    
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"Pie Chart" ExampleDesc:@"A simple demonstration of the pie chart."]];
    
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"Bubble Chart" ExampleDesc:@"A simple demonstration of the Bubble chart."]];
    
    [self.dataArray addObject:[MainCustomModel setupExampleTitle:@"Radar Chart" ExampleDesc:@"A simple demonstration of the Radar chart."]];

    
    
    [self.tableview reloadData];
}

#pragma mark ----------页面跳转
-(void)pushExampleController:(MainCustomModel *)model{
    if ([model.exampleTitle isEqualToString:@"Line Chart"]) {
        SBLineChartViewController *vc = [[SBLineChartViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.exampleTitle isEqualToString:@"Bar Chart"]) {
        SBBarChartViewController *vc = [[SBBarChartViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.exampleTitle isEqualToString:@"Pie Chart"]) {
        SBPieChartViewController *vc = [[SBPieChartViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.exampleTitle isEqualToString:@"Bubble Chart"]) {
        SBBubbleChartViewController *vc = [[SBBubbleChartViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.exampleTitle isEqualToString:@"Radar Chart"]) {
        SBRadarChartViewController *vc = [[SBRadarChartViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark ----------TableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MainCustomCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushExampleController:self.dataArray[indexPath.row]];
}

#pragma mark ----------懒加载页面控件
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = SB_INIT_TABLEVIEW(UITableViewStylePlain, self);
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MainCustomCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([MainCustomCell class])];
    }
    return _tableview;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray =[[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end

