//
//  SBNumberScroller.m
//  Tools
//
//  Created by 刘永吉 on 2021/1/18.
//  Copyright © 2021 lyj. All rights reserved.
//

#import "SBNumberScroller.h"

@interface SBNumberScroller ()

@property (nonatomic , strong ) NSMutableArray *numbersText;//保存拆分出来的数字
@property (nonatomic , strong ) NSMutableArray *scrollLayers;
@property (nonatomic , strong ) NSMutableArray *scrollLabels;//保存label

@end

@implementation SBNumberScroller

#pragma mark ---------init
// 支持 frame 方式和 xib 方式 init
- (instancetype)init{
    if (self == [super init]) {
        [self setupConfig];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupConfig];
    }
    return self;
}

#pragma mark ---------刷新视图
- (void)refresh{
    [self prepareAnimations];
}

- (void)startAnimation{
    [self createAnimations];
}

- (void)stopAnimation{
    for (CALayer *layer in _scrollLayers) {
        [layer removeAnimationForKey:@"AxcUI_NumberScrollView"];
    }
}

#pragma mark ----------初始化默认配置
- (void)setupConfig{
    self.sbDuration = 1.5;
    self.sbDurationOffset = 0.2;
    self.sbDensity = 5;
    self.sbMinLength = 0;
    self.sbIsAscending = NO;
    
    self.sbFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42];;
    self.sbTextColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor blackColor];
}

- (void)prepareAnimations{
    // 先删除旧数据
    for (CALayer *layer in self.scrollLayers) {
        [layer removeFromSuperlayer];
    }
    [self.numbersText removeAllObjects];
    [self.scrollLayers removeAllObjects];
    [self.scrollLabels removeAllObjects];
    
    // 配置新的数据和UI
    [self configNumbersText];
    [self configScrollLayers];
}

- (void)configNumbersText{
    NSString *numberStr = [self.sbNumber stringValue];
    // 如果 number 长度小于 最小长度就补0
    // 这里需要注意一下 axcUI_minLength 和 length 都是NSUInteger类型 如果相减得负数的话会有问题
    for (NSInteger i = 0; i < (NSInteger)self.sbMinLength - (NSInteger)numberStr.length; i++) {
        [self.numbersText addObject:@"0"];
    }
    // 取出 number 各位数
    for (NSUInteger i = 0; i < numberStr.length; i++) {
        [self.numbersText addObject:[numberStr substringWithRange:NSMakeRange(i, 1)]];
    }
}

- (void)configScrollLayers{
    // 平均分配宽度
    CGFloat width = CGRectGetWidth(self.frame) / _numbersText.count;
    CGFloat height = CGRectGetHeight(self.frame);
    // 创建和配置 scrollLayer
    for (NSUInteger i = 0; i < self.numbersText.count; i++) {
        CAScrollLayer *layer = [CAScrollLayer layer];
        layer.frame = CGRectMake(i*width, 0, width, height);
        [self.scrollLayers addObject:layer];
        [self.layer addSublayer:layer];
        
        NSString *numberText = self.numbersText[i];
        [self configScrollLayer:layer numberText:numberText];
    }
}

- (void)configScrollLayer:(CAScrollLayer *)layer numberText:(NSString *)numberText{
    NSInteger number = [numberText integerValue];
    NSMutableArray *scrollNumbers = [NSMutableArray array];
    // 添加要滚动的数字
    for (NSInteger i = 0; i < self.sbDensity + 1; i++) {
        [scrollNumbers addObject:[NSString stringWithFormat:@"%u", (unsigned int)((number+i) % 10)]];
    }
    [scrollNumbers addObject:numberText];
    // 创建 scrollLayer 的内容，数字降序排序
    // 修改局部变量的值需要使用 __block 修饰符
    __block CGFloat height = 0;
    [scrollNumbers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [self createLabel:text];
        label.frame = CGRectMake(0, height, CGRectGetWidth(layer.frame), CGRectGetHeight(layer.frame));
        [layer addSublayer:label.layer];
        // 保存label，防止对象被回收
        [self.scrollLabels addObject:label];
        // 累加高度
        height = CGRectGetMaxY(label.frame);
    }];
}

- (UILabel *)createLabel:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = self.sbTextColor;
    label.font = self.sbFont;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = text;
    
    return label;
}

- (void)createAnimations{
    // 第一个 layer 的动画持续时间
    NSTimeInterval duration = self.sbDuration - ((self.numbersText.count-1) * self.sbDurationOffset);
    for (CALayer *layer in self.scrollLayers) {
        CGFloat maxY = [[layer.sublayers lastObject] frame].origin.y;
        // keyPath 是 sublayerTransform ，因为动画应用于 layer 的 subLayer。
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
        animation.duration = duration;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        // 滚动方向
        if (self.sbIsAscending) {
            animation.fromValue = @0;
            animation.toValue = [NSNumber numberWithFloat:-maxY];
        } else {
            animation.fromValue = [NSNumber numberWithFloat:-maxY];
            animation.toValue = @0;
        }
        // 添加动画
        [layer addAnimation:animation forKey:@"AxcUI_NumberScrollView"];
        // 累加动画持续时间
        duration += self.sbDurationOffset;
    }
}

#pragma mark ---------set方法 刷新视图
- (void)setSbNumber:(NSNumber *)sbNumber{
    _sbNumber = sbNumber;
    [self setNeedsDisplay];
    // 准备动画
    [self prepareAnimations];
}

- (void)setSbMinLength:(NSUInteger)sbMinLength{
    _sbMinLength = sbMinLength;
    [self refresh];

}
- (void)setSbTextColor:(UIColor *)sbTextColor{
    _sbTextColor = sbTextColor;
    [self refresh];
}


#pragma marlk ----------懒加载
-(NSMutableArray *)numbersText{
    if (!_numbersText) {
        _numbersText = [[NSMutableArray alloc]init];
    }
    return _numbersText;
}

-(NSMutableArray *)scrollLayers{
    if (!_scrollLayers) {
        _scrollLayers = [[NSMutableArray alloc]init];
    }
    return _scrollLayers;
}

-(NSMutableArray *)scrollLabels{
    if (!_scrollLabels) {
        _scrollLabels = [[NSMutableArray alloc]init];
    }
    return _scrollLabels;
}
@end
