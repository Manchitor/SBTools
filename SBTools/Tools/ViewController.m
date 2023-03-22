//
//  ViewController.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/5.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "ViewController.h"
#import "SBToolsHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[SBTools sb_string_format_phone:@"18721218206"]);
}

@end
