//
//  SBRadarCustomChartsViewController.m
//  Tools
//
//  Created by 刘永吉 on 2023/5/11.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBRadarCustomChartsViewController.h"
#import "SBRadarChartsView.h"
@interface SBRadarCustomChartsViewController ()

@end

@implementation SBRadarCustomChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    SBRadarChartsView *radar = [[SBRadarChartsView alloc] initWithFrame:CGRectMake(20, 100, SB_SCREEN_WIDTH - 40, SB_SCREEN_WIDTH - 40)];
    [self.view addSubview:radar];
}


@end
