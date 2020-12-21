//
//  JZAlbumViewController.m
//  aoyouHH
//
//  Created by lyj on 15/4/27.
//  Copyright (c) 2015年 lyj. All rights reserved.
//

#import "JZAlbumViewController.h"
//#import "UIImageView+WebCache.h"
//#import "MBProgressHUD.h"
#import "PhotoView.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#define __MainScreen_Width [UIScreen mainScreen].bounds.size.width
#define __MainScreen_Height [UIScreen mainScreen].bounds.size.height

@interface JZAlbumViewController ()<UIScrollViewDelegate,PhotoViewDelegate>
{
    CGFloat lastScale;
//    MBProgressHUD *HUD;
    NSMutableArray *_subViewList;
}
@property (nonatomic,strong)UIImageView *imagesave;

@end

@implementation JZAlbumViewController


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
        _subViewList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lastScale = 1.0;
    self.view.backgroundColor = [UIColor blackColor];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapView)];
//    [self.view addGestureRecognizer:tap];

    [self initScrollView];
//    [self addLabels];
    [self setUpSaveBtn];
    [self setPicCurrentIndex:self.currentIndex];
}

-(void)setUpSaveBtn{
    /**  添加保存按钮 */
    [self.view addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
        make.width.equalTo(@90);
    }];

}
-(UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:nil forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 13.3;
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _saveBtn.layer.borderWidth = 0.5;
        _saveBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _saveBtn.clipsToBounds = YES;
        [_saveBtn addTarget:self  action:@selector(saveBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.6];
    }
    return _saveBtn;
}
-(void)saveBtnDidClick:(UIButton *)sender{
    ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
    {
        //无权限
        [[[UIAlertView alloc]initWithTitle:@"权限访问" message:@"请到iPhone的”设置-隐私“选项中，允许乡邻访问你的相册权限" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:NULL, nil] show];
        
    }else{
        [self loadImageFinished:self.imgArr[self.currentIndex]];
    }

}
/**  保存图片 */
- (void)loadImageFinished:(id)image
{
    if ([image isKindOfClass:[UIImage class]]) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //写入图片到相册
            PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:(UIImage *)image];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"success = %d, error = %@", success, error);
                if (success) {
                    self.saveBtn.enabled = NO;
                    NSLog(@"保存成功");
                    [ToastUtil showMessage:@"保存成功"];

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
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                //写入图片到相册
                PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
                
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"success = %d, error = %@", success, error);
                    if (success) {
                        self.saveBtn.enabled = NO;
                        
                        [ToastUtil showMessage:@"保存成功"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.saveBtn.enabled = YES;
                        });
                    }
                });
                
            }];
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initScrollView{
//    [[SDImageCache sharedImageCache] cleanDisk];
//    [[SDImageCache sharedImageCache] clearMemory];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*__MainScreen_Width, __MainScreen_Height);
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    //设置放大缩小的最大，最小倍数
//    self.scrollView.minimumZoomScale = 1;
//    self.scrollView.maximumZoomScale = 2;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < self.imgArr.count; i++) {
        [_subViewList addObject:[NSNull class]];
    }

}

-(void)addLabels{
    self.sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, __MainScreen_Height-64-49, 60, 30)];
    self.sliderLabel.backgroundColor = [UIColor clearColor];
    self.sliderLabel.textColor = [UIColor whiteColor];
    self.sliderLabel.text = [NSString stringWithFormat:@"%ld/%lu",self.currentIndex+1,(unsigned long)self.imgArr.count];
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
    }else{
        PhotoView *photoV = (PhotoView *)currentPhotoView;
    }
    
}
-(UIImageView *)imagesave{
    if (!_imagesave) {
        _imagesave = [[UIImageView alloc]init];
    }
    return _imagesave;
}
#pragma mark - PhotoViewDelegate
-(void)TapHiddenPhotoView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)OnTapView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//手势
-(void)pinGes:(UIPinchGestureRecognizer *)sender{
    if ([sender state] == UIGestureRecognizerStateBegan) {
        lastScale = 1.0;
    }
    CGFloat scale = 1.0 - (lastScale -[sender scale]);
    lastScale = [sender scale];
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*__MainScreen_Width, __MainScreen_Height*lastScale);
    NSLog(@"scale:%f   lastScale:%f",scale,lastScale);
    CATransform3D newTransform = CATransform3DScale(sender.view.layer.transform, scale, scale, 1);
    
    sender.view.layer.transform = newTransform;
    if ([sender state] == UIGestureRecognizerStateEnded) {
        //
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    int i = scrollView.contentOffset.x/__MainScreen_Width+1;
    [self loadPhote:i-1];
    self.sliderLabel.text = [NSString stringWithFormat:@"%d/%lu",i,(unsigned long)self.imgArr.count];
}

-(void)dealloc{
    NSLog(@"我释放了");
}
@end
