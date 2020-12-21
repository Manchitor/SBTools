//
//  SBPhotoRevealViewController.m
//  Tools
//
//  Created by 刘永吉 on 2020/9/25.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBPhotoRevealViewController.h"
#import "PhotoView.h"
#import <Photos/Photos.h>

#define __MainScreen_Width [UIScreen mainScreen].bounds.size.width
#define __MainScreen_Height [UIScreen mainScreen].bounds.size.height

@interface SBPhotoRevealViewController ()<UIScrollViewDelegate,PhotoViewDelegate>

@property (nonatomic,strong)UIImageView *imagesave;

@property (nonatomic,assign)CGFloat lastScale;

@property (nonatomic,strong)NSMutableArray *subViewList;


/**
 *  显示scrollView
 */
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SBPhotoRevealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupconfig];
    
    [self setupui];
    
    [self setPicCurrentIndex:self.currentIndex];
    
}
-(void)setupconfig{
    
    self.lastScale = 1.0;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapHiddenPhotoView)];
    [self.view addGestureRecognizer:tap];
    
}
-(void)setupui{
    
    [self.view addSubview:self.scrollView];
    
    [self.view addSubview:self.saveBtn];
    
    [self.view addSubview:self.sliderLabel];
}

-(void)setPicCurrentIndex:(NSInteger)currentIndex{
    
    _currentIndex = currentIndex;
    self.scrollView.contentOffset = CGPointMake(__MainScreen_Width*currentIndex, 0);
    [self loadPhote:_currentIndex];
    [self loadPhote:_currentIndex+1];
    [self loadPhote:_currentIndex-1];
}

-(void)loadPhote:(NSInteger)index{
    if (index<0 || index >=self.imgArr.count) {
        return;
    }
    
    id currentPhotoView = [_subViewList objectAtIndex:index];
    if (![currentPhotoView isKindOfClass:[PhotoView class]]) {
        //url数组
        CGRect frame = CGRectMake(index*_scrollView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        PhotoView *photoV;
        if ([self.imgArr[0] isKindOfClass:[NSString class]]) {
            photoV = [[PhotoView alloc] initWithFrame:frame withPhotoUrl:[self.imgArr objectAtIndex:index]];
        }else{
            photoV = [[PhotoView alloc] initWithFrame:frame withPhotoImage:[self.imgArr objectAtIndex:index]];
        }
        
        
        photoV.delegate = self;
        [self.scrollView insertSubview:photoV atIndex:0];
        [_subViewList replaceObjectAtIndex:index withObject:photoV];
    }
}
#pragma mark --------- 保存图片
-(void)saveBtnDidClick:(UIButton *)sender{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadImageFinished:self.imgArr[self.currentIndex]];
            });
        }else{
            //无权限
            NSLog(@"无权限");
        }
    }];
}
/**  保存图片 */
- (void)loadImageFinished:(id)image
{
    if ([image isKindOfClass:[UIImage class]]) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //写入图片到相册
            [PHAssetChangeRequest creationRequestForAssetFromImage:(UIImage *)image];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    self.saveBtn.enabled = NO;
                    NSLog(@"保存成功");
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.saveBtn.enabled = YES;
                    });
                }
            });
            
        }];
    }else if([image isKindOfClass:[NSString class]]){
        [self.view addSubview:self.imagesave];
        self.imagesave.hidden = YES;
        [self.imagesave sd_setImageWithURL:[NSURL URLWithString:(NSString *)image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [self loadImageFinished:image];
        }];
    }
    
}
#pragma mark --------- PhotoViewDelegate
-(void)TapHiddenPhotoView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//手势
-(void)pinGes:(UIPinchGestureRecognizer *)sender{
    if ([sender state] == UIGestureRecognizerStateBegan) {
        self.lastScale = 1.0;
    }
    CGFloat scale = 1.0 - (self.lastScale -[sender scale]);
    self.lastScale = [sender scale];
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*__MainScreen_Width, __MainScreen_Height*self.lastScale);
    NSLog(@"scale:%f   lastScale:%f",scale,self.lastScale);
    CATransform3D newTransform = CATransform3DScale(sender.view.layer.transform, scale, scale, 1);
    
    sender.view.layer.transform = newTransform;
    if ([sender state] == UIGestureRecognizerStateEnded) {
        //
    }
}
#pragma mark --------- UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int i = scrollView.contentOffset.x/__MainScreen_Width+1;
    [self loadPhote:i-1];
    self.sliderLabel.text = [NSString stringWithFormat:@"%d/%lu",i,(unsigned long)self.imgArr.count];
}

#pragma mark --------- 懒加载控件
-(NSMutableArray *)subViewList{
    if (!_subViewList) {
        _subViewList = [[NSMutableArray alloc]init];
    }
    return _subViewList;
}

-(UIImageView *)imagesave{
    if (!_imagesave) {
        _imagesave = [[UIImageView alloc]init];
    }
    return _imagesave;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        _scrollView.contentSize = CGSizeMake(self.imgArr.count*__MainScreen_Width, __MainScreen_Height);
        _scrollView.delegate = self;
        _scrollView.contentOffset = CGPointMake(0, 0);
        //设置放大缩小的最大，最小倍数
        //self.scrollView.minimumZoomScale = 1;
        //self.scrollView.maximumZoomScale = 2;
        
        for (int i = 0; i < self.imgArr.count; i++) {
            [_subViewList addObject:[NSNull class]];
        }
    }
    return _scrollView;
}

-(UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc]initWithFrame:CGRectMake((__MainScreen_Width-90)/2.0, __MainScreen_Height-60-30, 90, 30)];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:nil forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 15;
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _saveBtn.layer.borderWidth = 0.5;
        _saveBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _saveBtn.clipsToBounds = YES;
        [_saveBtn addTarget:self  action:@selector(saveBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.6];
    }
    return _saveBtn;
}

-(UILabel *)sliderLabel{
    if (!_sliderLabel) {
        _sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(__MainScreen_Width-80, __MainScreen_Height-64-49, 60, 30)];
        _sliderLabel.backgroundColor = [UIColor clearColor];
        _sliderLabel.textColor = [UIColor whiteColor];
        _sliderLabel.textAlignment = NSTextAlignmentRight;
        _sliderLabel.text = [NSString stringWithFormat:@"%ld/%lu",self.currentIndex+1,(unsigned long)self.imgArr.count];
    }
    return _sliderLabel;
}
@end
