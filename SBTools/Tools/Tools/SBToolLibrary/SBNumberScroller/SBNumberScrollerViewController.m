//
//  SBNumberScrollerViewController.m
//  Tools
//
//  Created by 刘永吉 on 2023/3/30.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBNumberScrollerViewController.h"
#import "SBNumberScroller.h"


@interface SBNumberScrollerViewController ()
@property (nonatomic,strong) SBNumberScroller *ns;
@end

@implementation SBNumberScrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.ns = [[SBNumberScroller alloc] init];
    [self.view addSubview:self.ns];
    self.ns.frame = CGRectMake(100, 100, 50, 50);
    // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.ns.sbNumber = @(arc4random() % 10);
    [self.ns startAnimation];  
}
@end
