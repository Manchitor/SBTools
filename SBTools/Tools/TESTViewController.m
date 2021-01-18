//
//  TESTViewController.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/19.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "TESTViewController.h"
#import "SBToolsHeader.h"
#import "UILabel+TimerColor.h"
//获得屏幕的宽高
#define mainW [UIScreen mainScreen].bounds.size.width
#define mainH [UIScreen mainScreen].bounds.size.height

@interface TESTViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;

@property (nonatomic, strong) NSArray *typeArray;



@end

@implementation TESTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.tf.hidden = YES;
    //创建控件
//     [self creatControl];
    
    // _typeArray = @[kCATransitionFade, kCATransitionPush, kCATransitionMoveIn, kCATransitionReveal, @"cube", @"suckEffect", @"oglFlip", @"rippleEffect", @"pageCurl", @"pageUnCurl", @"cameraIrisHollowOpen", @"cameraIrisHollowClose"];
}

- (void)creatControl
{
    NSArray *titleArray = @[@"淡化效果", @"推进效果", @"滑入效果", @"滑出效果", @"立方体效果", @"吮吸效果", @"翻转效果", @"波纹效果", @"翻页效果", @"反翻页效果", @"开镜头效果", @"关镜头效果"];
    
    for (int i = 0; i < titleArray.count; i++) {
        CGFloat X = i % 2 == 0 ? mainW * 0.1 : mainW * 0.6;
        CGFloat Y = 64 + i / 2 * mainW * 0.15;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(X, Y, mainW * 0.3, mainW * 0.1)];
        btn.tag = i;
        [btn setBackgroundColor:[UIColor colorWithRed:0.6f green:0.7f blue:0.6f alpha:0.7f]];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)btnOnClick:(UIButton *)btn
{
    static int i = 0;
    
    i = i == 0 ? 1 : 0;
    self.view.backgroundColor = i == 0 ? [UIColor greenColor] : [UIColor redColor];
    
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置时间
    animation.duration = 1.0f;
    
    //设置类型
    animation.type = _typeArray[btn.tag];
    
    //设置方向
    animation.subtype = kCATransitionFromRight;
    
    
    [self.view.layer addAnimation:animation forKey:@"animation"];
}


-(void)dealloc{
    NSLog(@"TESTViewController dealloc");
}
@end
