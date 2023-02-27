//
//  ViewController.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/5.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "ViewController.h"
#import "SBToolsHeader.h"

#import "ERCalendarPickerViewController.h"//日历

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ERCalendarPickerViewController *vc = [[ERCalendarPickerViewController alloc] initWithNibName:NSStringFromClass([ERCalendarPickerViewController class]) bundle:[NSBundle mainBundle]];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}
@end
