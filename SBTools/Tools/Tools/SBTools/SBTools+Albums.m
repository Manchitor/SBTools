//
//  SBTools+Albums.m
//  Tools
//
//  Created by 刘永吉 on 2020/9/8.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools+Albums.h"
#import <UIKit/UIKit.h>

#import "SBTools+UIImage.h"
@implementation SBTools (Albums)
/**
 获取相册的使用权限
 */
+(void)sb_albums_permission_authorization:(void(^)(PHAuthorizationStatus status))handler{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        //ALAuthorizationStatusNotDetermined （用户还没有关于这个应用程序做出了选择）
        //PHAuthorizationStatusRestricted（这个应用程序未被授权访问图片数据。用户不能更改该应用程序的状态,可能是由于活动的限制,如家长控制到位。）
        //PHAuthorizationStatusDenied （用户已经明确否认了这个应用程序访问图片数据）
        //PHAuthorizationStatusAuthorized （用户授权此应用程序访问图片数据）
        //注意：回调结果后需回到主线程操作 dispatch_async(dispatch_get_main_queue(), ^{ <#statements#> });
        
        handler(status);
    }];
}
/**
 获取相册自定义相册
 */
+(PHFetchResult<PHAssetCollection *> *)sb_albums_custom_asset_collections{
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    return assetCollections;
}
/**
 获取相册中所有文件集合
 */
+(PHFetchResult<PHAsset *> *)sb_albums_fetch_assets_collection:(PHAssetCollection *)assetCollection{
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    return assets;
}
/**
 获取相PHAsset 图片等信息
 */
+(void)sb_albums_asset_info:(PHAsset *)asset Handler:(void (^)(UIImage *_Nullable image,NSString  *_Nullable filename,PHAssetMediaType mediaType))infoHandler{
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 是否要原图
    BOOL original = YES;
    CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        //文件名
        NSString *filename = [asset valueForKey:@"originalFilename"];//originalFilename, （filename：文件原始的名字）
        
        infoHandler(result,filename,asset.mediaType);
        
    }];
}
/**
 获取PHAsset 视频路径等信息
 */
+ (void)sb_albums_fetch_video_path_asset:(PHAsset *)Asset Complete:(void (^)(NSURL *filePatch,NSData *data,NSString *durationTime))videoBlock {
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHVideoRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    
    [[PHImageManager defaultManager] requestAVAssetForVideo:Asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        
        AVURLAsset *URLAsset = (AVURLAsset *)asset;//视频url
        NSURL *url = URLAsset.URL;
        
        NSData *data = [NSData dataWithContentsOfURL:URLAsset.URL];//视频data
        int m = (int)Asset.duration/60;
        int s = (int)Asset.duration %60;
        int h = (int)Asset.duration/3600;
        
        NSString *durationTime = [NSString stringWithFormat:@"%dh%dm%ds",h,m,s];
        
        videoBlock(url,data,durationTime);
    }];
}
/**
 通过资源获取图片的数据
 
 @param mAsset 资源文件
 @param imageBlock 图片数据回传
 */
+ (void)sb_albums_fetch_image_info_asset:(PHAsset*)mAsset imageBlock:(void(^)(NSData* data,NSString *filename))imageBlock{
    
    [[PHImageManager defaultManager] requestImageDataForAsset:mAsset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        
        NSData *data = UIImageJPEGRepresentation([SBTools sb_fix_orientation_data:imageData], 0.5);
        //文件名
        NSString *filename = [mAsset valueForKey:@"originalFilename"];//originalFilename, （filename：文件原始的名字）
        
        // 直接得到最终的 NSData 数据
        if (imageBlock) {
            imageBlock(data,filename);
        }
        
    }];
}

/**
 创建相册
 */
+(BOOL)sb_albums_create_asset_collection:(NSString *)phtoname{
    //获取所有相册
    PHFetchResult <PHAssetCollection *> *arr = [SBTools sb_albums_custom_asset_collections];
    BOOL isHas = NO;
    for (PHAssetCollection *temp in arr) {
        if ([temp.localizedTitle isEqualToString:phtoname]){
            isHas = YES;
        }
    }
    if (isHas) {//已经有此相册了
        NSLog(@"相册已经存在");
        return NO;
    }
    //创建
    NSError *error = nil;
    // 代码执行到这里，说明还没有自定义相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:phtoname];
    } error:&error];
    
    return error ? NO : YES;
}
@end
