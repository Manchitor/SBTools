//
//  SBBubbleViewController.m
//  Tools
//
//  Created by 刘永吉 on 2023/4/24.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBBubbleViewController.h"
#import "SBBubbleImageView.h"

@interface SBBubbleViewController ()
@property (nonatomic,strong) UIView *bg;

@property (strong,nonatomic) NSMutableArray<SBBubbleImageView *> *itemArray;


@end

@implementation SBBubbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupui];
    [self setupdata];
}

-(void)setupui{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bg];
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(SB_SCREEN_WIDTH - 40);
    }];
}

-(void)setupdata{
    for (int index = 0; index < 6; index++) {
        int x = arc4random()%(int)(SB_SCREEN_WIDTH - 40 - 40);
        int y = arc4random()%(200 - 40);
        NSLog(@"index:%d  x:%d y:%d",index,x,y);
        
        SBBubbleImageView *item = [[SBBubbleImageView alloc] init];
        item.backgroundColor = [UIColor redColor];
        item.alpha = 0.7;
        item.layer.cornerRadius = 20;
        item.clipsToBounds = YES;
        item.frame = CGRectMake(x, y, 40, 40);
        [self.bg addSubview:item];
        [self.itemArray addObject:item];
    }
}

#pragma mark ----------背景视图
-(UIView *)bg{
    if (!_bg) {
        _bg = [[UIView alloc] init];
        _bg.backgroundColor = SBCOLORHEX(0xf8f8f8, 1);
    }
    return _bg;
}


-(NSMutableArray<SBBubbleImageView *> *)itemArray{
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (SBBubbleImageView *item in self.itemArray) {
        [item startBubbleAnimation:10 radius:30];
    }
}
@end
