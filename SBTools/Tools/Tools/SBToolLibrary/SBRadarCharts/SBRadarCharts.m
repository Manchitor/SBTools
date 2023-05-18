//
//  SBRadarCharts.m
//  Tools
//
//  Created by 刘永吉 on 2023/5/9.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBRadarCharts.h"

#define ColorWithHEAL [UIColor colorWithRed:0/255.0f green:197/255.0f blue:188/255.0f alpha:1]//大图层的颜色

#define P_M(x,y) CGPointMake(x, y)

@implementation SBRadarCharts

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    _radius = self.frame.size.width/2.0;
    _dioWdith = 5;
    _dioBoderWdith = 1;

    _labelWidth = 50;
    _labelHeight = 30;
    
    _themColor = ColorWithHEAL;
    _cirlColor = [UIColor lightGrayColor];
    
    _cirlMargin = 30;
    
    _values = @[@"40",@"50",@"80",@"50",@"90",@"50",@"70",@"90",@"30"];
    _titles = @[@"阴虚",@"痰湿",@"温热",@"血瘀",@"气郁",@"特禀",@"平和",@"气虚",@"阳虚"];
    
    _imgWidth = 20;
    _imgBoderWidth = 1;
    
    _proportion = 0.2;

    _img = [UIImage imageNamed:@"背景.jpg"];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //设置frame
}


#pragma mark - 空心圆
- (void)drawRect:(CGRect)rect
{
    
    for (UIView *vi in self.subviews) {
        [vi removeFromSuperview];
    }
    //画虚线的
    CGFloat dashPattern[] = {2,1};// 实线长为2，空白为1
    CGFloat lineWidth = 0.5;
    
    CGFloat _headerimageR = _imgWidth/2.0;//头像的半径
    
    //画多少个圆环
    for (int i = 0; i<3; i++) {
        UIBezierPath* aPath_yuanhuan = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(i*_cirlMargin, i*_cirlMargin, self.frame.size.width-(i*_cirlMargin*2), self.frame.size.width-(i*_cirlMargin*2))];
        [aPath_yuanhuan setLineDash:dashPattern count:1 phase:1];
        aPath_yuanhuan.lineWidth = lineWidth;
        [_cirlColor set];
        aPath_yuanhuan.lineCapStyle = kCGLineCapRound; //线条拐角
        aPath_yuanhuan.lineJoinStyle = kCGLineJoinRound; //终点处理
        [aPath_yuanhuan stroke];
    }
    float maxValue = [[_values valueForKeyPath:@"@max.intValue"] floatValue];//value array里面的最大值
    UIBezierPath* aPath = [UIBezierPath bezierPath];//🌿外边的😊大图层
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    UIBezierPath* aPathsmall = [UIBezierPath bezierPath];//🌿里边的😊小图层
    aPathsmall.lineWidth = 1.0;
    aPathsmall.lineCapStyle = kCGLineCapRound; //线条拐角
    aPathsmall.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    NSMutableArray *pointArray = [NSMutableArray array];//大图层的顶点位置
    NSMutableArray *pointArraysmall = [NSMutableArray array];//小涂层的顶点位置
    
    //提取出大小图层的point
    for (int i = 0; i<_values.count; i++) {
        
        NSValue *value = [NSValue valueWithCGPoint:[self calcCircleCoordinateWithCenter:CGPointMake(_radius, _radius) andWithAngle:i*(360/_values.count) andWithRadius:([_values[i] floatValue]/maxValue+(_headerimageR+_dioWdith+_dioBoderWdith+_imgBoderWidth)/_radius)*(_radius-_headerimageR-_dioBoderWdith-_dioWdith-_imgBoderWidth)]];//20为头像的半径
        
        [pointArray addObject:value];
        
        NSValue *valuesmall = [NSValue valueWithCGPoint:[self calcCircleCoordinateWithCenter:CGPointMake(_radius, _radius) andWithAngle:i*(360/_values.count) andWithRadius:([_values[i] floatValue]/maxValue+(_headerimageR+_dioBoderWdith+_imgBoderWidth)/_radius-_proportion)*(_radius-_headerimageR-_dioBoderWdith-_dioWdith-_imgBoderWidth)]];//20为头像的半径
        
        [pointArraysmall addObject:valuesmall];
        
        
        
    }
    
    for (int i = 0; i<pointArray.count; i++) {
        UIBezierPath *path3 = [UIBezierPath bezierPath];
        [path3 moveToPoint:CGPointMake(_radius,_radius)];
        CGPoint pointyuanshangde = [self calcCircleCoordinateWithCenter:CGPointMake(_radius,_radius) andWithAngle:i*(360/pointArray.count) andWithRadius:_radius];
        [path3 addLineToPoint:pointyuanshangde];
        [path3 setLineWidth:lineWidth];
        [path3 setLineDash:dashPattern count:1 phase:1];
        [[UIColor lightGrayColor] setStroke];
        [path3 stroke];//画的圆环
        CGPoint p = [pointArray[i] CGPointValue];
        CGPoint psmall = [pointArraysmall[i] CGPointValue];
        
        if (i == 0) {
            [aPath moveToPoint:p];
            [aPathsmall moveToPoint:psmall];
        }else{
            //画曲线 找出控制点
            //            CGPoint nextP = [pointArray[i-1] CGPointValue];
            //            CGPoint control1 = P_M(p.x + (nextP.x - p.x) / 2.0, nextP.y);
            //            CGPoint control2 = P_M(p.x + (nextP.x - p.x) / 2.0, p.y);
            //
            //            [aPath addCurveToPoint:p controlPoint1:control1 controlPoint2:control2];
        }
        
        [aPath addLineToPoint:p];
        [aPathsmall addLineToPoint:psmall];
        [[_themColor colorWithAlphaComponent:0.3] setFill];
        
        
        UIView *cile = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _dioWdith, _dioWdith)];
        cile.backgroundColor = [UIColor whiteColor];
        
        cile.layer.borderWidth = _dioBoderWdith;
        cile.layer.borderColor = _themColor.CGColor;
        cile.layer.masksToBounds = YES;
        cile.layer.cornerRadius = _dioWdith/2.0;
        cile.center = p;
        [self addSubview:cile];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _labelWidth, _labelHeight)];
        label.text = _titles[i];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = _themColor;
        CGFloat selfWidth = self.frame.size.width;
        CGFloat selfHeight = self.frame.size.height;
        CGFloat labelWidth = label.frame.size.width;
        CGFloat labelHeight = label.frame.size.height;
        
        if (p.x<selfWidth/2-labelWidth) {
            CGFloat x = p.x - labelWidth/2;
            CGFloat y;
            if (p.y<(selfHeight/2-labelHeight)) {
                y = p.y - labelHeight/2;
                
            } else {
                y = p.y + labelHeight/2;
                
            }
            label.center = CGPointMake(x, y);
            
        } else {
            CGFloat x = p.x + labelWidth/2;
            
            CGFloat y;
            if (p.y<(selfHeight/2-labelHeight)) {
                y = p.y - labelHeight/2;
                
            } else {
                y = p.y + labelHeight/2;
                
            }
            label.center = CGPointMake(x, y);
        }
        if (p.y>(selfHeight/2-labelHeight/2)&&p.y<(selfHeight/2+labelHeight/2)) {
            if (p.x<selfWidth/2-labelHeight) {
                
                label.center = CGPointMake(p.x-labelWidth/2, p.y);
            }else{
                label.center = CGPointMake(p.x+labelWidth/2, p.y);
            }
        }else{
            if (p.x>(selfWidth/2-labelWidth/2)&&p.x<(selfWidth/2+labelWidth/2)) {
                if (p.y<selfHeight/2-labelWidth) {
                    label.center = CGPointMake(p.x, p.y-labelHeight/2);
                } else {
                    label.center = CGPointMake(p.x, p.y+labelHeight/2);
                }
            }
        }
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
    }
    
    [aPath fill];
    [aPathsmall fill];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _imgWidth, _imgWidth)];
    [imageview setImage:_img];
    imageview.center = CGPointMake(_radius, _radius);
    imageview.layer.masksToBounds = YES;
    imageview.layer.cornerRadius = _headerimageR;
    imageview.layer.borderWidth = _imgBoderWidth;
    imageview.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:imageview];
    
}
#pragma mark 计算圆圈上点在IOS系统中的坐标
-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}
/**
 ：douxindong
 ：2017-4-20 1:02:26
 : 1.0.0
 --------------------------------------------------------------
 功能说明
 --------------------------------------------------------------
 根据IOS视图中圆组件的中心点(x,y)、半径(r)、圆周上某一点与圆心的角度这3个
 条件来计算出该圆周某一点在IOS中的坐标(x2,y2)。
 
 注意：
 （1）IOS坐标体系与数学坐标体系有差别，因此不能完全采用数学计算公式。
 （2）数学计算公式：
 x2=x+r*cos(角度值*PI/180)
 y2=y+r*sin(角度值*PI/180)
 （3）IOS中计算公式：
 x2=x+r*cos(角度值*PI/180)
 y2=y-r*sin(角度值*PI/180)
 
 --------------------------------------------------------------
 参数说明
 --------------------------------------------------------------
 @param (CGPoint) center
 
 圆圈在IOS视图中的中心坐标，即该圆视图的center属性
 
 @param (CGFloat) angle
 角度值，是0～360之间的值。
 注意：
 （1）请使用下面坐标图形进行理解。
 （2）角度是逆时针转的，从x轴中心(0,0)往右是0度角（或360度角），往左是180度角，往上是90度角，往下是270度角。
 
 (y)
 ^
 |
 |
 |
 |
 -----------------> (x)
 |(0,0)
 |
 |
 |
 
 @param (CGFloat) radius
 圆周半径
 */

@end
