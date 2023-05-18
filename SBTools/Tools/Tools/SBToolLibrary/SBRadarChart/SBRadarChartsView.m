//
//  SBRadarChartsView.m
//  Tools
//
//  Created by 刘永吉 on 2023/5/11.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBRadarChartsView.h"

#define P_M(x,y) CGPointMake(x, y)

@implementation SBRadarChartsView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =SBCOLORHEX(0xf8f8f8, 1);
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    //画虚线的
    CGFloat dashPattern[] = {2,1};// 实线长为2，空白为1
    
    CGFloat lineWidth = 0.5;
    
    //半径
    CGFloat radius = self.frame.size.width/2.0;
    
    //moke 数据
    NSMutableArray *datas = [NSMutableArray arrayWithArray:@[@"90",@"50",@"80",@"50",@"90",@"50",@"70",@"90",@"30"]];
    
    //圆环个数
    int count = 5;
    
    //圆环间距
    int margin = 30;
    
    //区域是否绘制曲线边线
    BOOL isCurve = NO;
    
    //1.绘制圆环
    for (int i = 0; i<count; i++) {
        UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(i*margin, i*margin, self.frame.size.width-(i*(margin *2)), self.frame.size.width-(i*(margin *2)))];
        [path setLineDash:dashPattern count:1 phase:1];
        path.lineWidth = lineWidth;
        [[UIColor lightGrayColor] set];
        path.lineCapStyle = kCGLineCapRound; //线条拐角
        path.lineJoinStyle = kCGLineJoinRound; //终点处理
        [path stroke];
    }
    
    
    
    //2.绘制穿插线（从圆心到最大圆斜线）
    for (int i = 0; i<datas.count; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(radius,radius)];
        CGPoint point = [self calcCircleCoordinateWithCenter:CGPointMake(radius,radius) andWithAngle:i*(360/datas.count) andWithRadius:radius];
        [path addLineToPoint:point];
        [path setLineWidth:lineWidth];
        [path setLineDash:dashPattern count:1 phase:1];
        [[UIColor lightGrayColor] setStroke];
        [path stroke];
    }
    
    //value array里面的最大值
    float maxValue = [[datas valueForKeyPath:@"@max.intValue"] floatValue];
    
    //3.获取数据源的每项point
    NSMutableArray *pointArray = [[NSMutableArray alloc] init];
    for (int index = 0; index < datas.count; index++) {
        CGPoint point = [self calcCircleCoordinateWithCenter:CGPointMake(radius, radius) andWithAngle:index*(360/datas.count) andWithRadius:[datas[index] floatValue]/maxValue *radius];
        NSValue *value = [NSValue valueWithCGPoint:point];
        [pointArray addObject:value];
    }
    
    //4.绘制图层
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    for (int index = 0; index < pointArray.count; index++) {
        
        CGPoint point = [pointArray[index] CGPointValue];

        if (index == 0) {
            [path moveToPoint:[pointArray[index] CGPointValue]];
        }else{
            //画曲线 找出控制点
            if (isCurve) {
                CGPoint nextP = [pointArray[index-1] CGPointValue];
                
                CGPoint control1 = P_M(point.x + (nextP.x - point.x) / 2.0, nextP.y);
                CGPoint control2 = P_M(point.x + (nextP.x - point.x) / 2.0, point.y);
                
                [path addCurveToPoint:point controlPoint1:control1 controlPoint2:control2];
            }
        }
        
        [path addLineToPoint:point];
        
        //5.绘制各每项数据顶点小圆点
        UIView *doi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
        doi.backgroundColor = [UIColor whiteColor];
        
        doi.layer.borderWidth = 1;
        doi.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
        doi.layer.masksToBounds = YES;
        doi.layer.cornerRadius = 5/2.0;
        doi.center = point;
        [self addSubview:doi];
    }
    [[[UIColor redColor] colorWithAlphaComponent:0.3] setFill];
    [path fill];

    
}

#pragma mark 计算圆圈上点在IOS系统中的坐标
-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}
@end
