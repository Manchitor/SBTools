//
//  SBBubleMoveViewController.m
//  Tools
//
//  Created by 刘永吉 on 2023/4/23.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBBubleMoveViewController.h"

@interface SBBubleMoveViewController ()
@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UIView *item;

@end

@implementation SBBubleMoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupui];
}

#pragma mark ---------初始化页面
-(void)setupui{
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(SB_SCREEN_WIDTH - 40);
    }];

    [self.contentView addSubview:self.item];
    self.item.frame = CGRectMake(10, 20, 40, 40);
}

-(void)startxAnimation{
    
    //X方向速度计算
    CGFloat sppe = (SB_SCREEN_WIDTH-40 - 40)/10.0;
    
    
    //x 将要移动的距离 这里才去随机距离。
    int Xr = arc4random()%(int)(SB_SCREEN_WIDTH-40 - self.item.frame.origin.x - 40);
    int Xl = arc4random()%(int)(self.item.frame.origin.x);
    
    //如果想移动到边界 碰壁折返效果 可直接取最大值
    //int Xr = (SB_SCREEN_WIDTH-40 - self.item.frame.origin.x - 40);
    //int Xl = (self.item.frame.origin.x);

    //随机此次移动方向
    BOOL directionL = (arc4random()%2 == 1);
    
    //方向临界值判断
    if (Xl<10) {
        directionL = NO;
    }
    if (Xr<10) {
        directionL = YES;
    }
    
    //动画时间计算
    CGFloat time = 0;
    if (directionL) {
        time = Xl/sppe;
    }else{
        time = Xr/sppe;
    }
    
    [UIView animateWithDuration: time  animations:^{
        if (directionL) {
            self.item.frame = CGRectMake(self.item.frame.origin.x - Xl, self.item.frame.origin.y, 40, 40);
        }else{
            self.item.frame = CGRectMake(self.item.frame.origin.x + Xr, self.item.frame.origin.y, 40, 40);
        }
    } completion:^(BOOL finished) {
        [self startxAnimation];
    }];
}
-(void)startyAnimation{
    //方向速度计算
    CGFloat sppe = (200)/10.0;
    
    
    //y 将要移动的距离右边
    int Xr = arc4random()%(int)(200 - self.item.frame.origin.y - 40);
    int Xl = arc4random()%(int)(self.item.frame.origin.y);
    
    //如果想移动到边界 碰壁折返效果 可直接取最大值
    //int Xr = (200 - self.item.frame.origin.y - 40);
    //int Xl = (self.item.frame.origin.y);

    //随机此次移动方向
    BOOL directionL = (arc4random()%2 == 1);
    
    //方向临界值判断
    if (Xl<10) {
        directionL = NO;
    }
    if (Xr<10) {
        directionL = YES;
    }
    
    //动画时间计算
    CGFloat time = 0;
    if (directionL) {
        time = Xl/sppe;
    }else{
        time = Xr/sppe;
    }
    
    [UIView animateWithDuration: time  animations:^{
        if (directionL) {
            self.item.frame = CGRectMake(self.item.frame.origin.x, self.item.frame.origin.y - Xl, 40, 40);
        }else{
            self.item.frame = CGRectMake(self.item.frame.origin.x, self.item.frame.origin.y + Xr, 40, 40);
        }
    } completion:^(BOOL finished) {
        [self startyAnimation];
    }];
}

#pragma mark ----------懒加载
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = SBCOLORHEX(0xf8f8f8, 1);
    }
    return _contentView;
}

-(UIView *)item{
    if (!_item) {
        _item = [[UIView alloc] init];
        _item.backgroundColor = [UIColor redColor];
    }
    return _item;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self startxAnimation];
    [self startyAnimation];

}
@end
