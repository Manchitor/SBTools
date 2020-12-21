//
//  SBTools+Albums.h
//  Tools
//
//  Created by 刘永吉 on 2020/9/8.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "SBTools.h"
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBTools (Albums)
/**
    获取相册的使用权限
 */
+(void)SB_RequestAuthorization:(void(^)(PHAuthorizationStatus status))handler;

/**
    获取相册自定义相册
 */
+(PHFetchResult<PHAssetCollection *> *)SB_FetchPHAssetCollections;

/**
   获取相册中所有文件集合
*/
+(PHFetchResult<PHAsset *> *)SB_FetchPHAssetsInCollection:(PHAssetCollection *)assetCollection;

/**
   获取相PHAsset 图片(视频封面) 文件名 文件类型 等信息
*/
+(void)SB_FetchPHAssetInfo:(PHAsset *)asset infoHandler:(void (^)(UIImage *_Nullable image,NSString  *_Nullable filename,PHAssetMediaType mediaType))infoHandler;

/**
   获取PHAsset 视频路径 data 时长 等信息
*/
+ (void)SB_FetchVideoPathFromPHAsset:(PHAsset *)Asset Complete:(void (^)(NSURL *filePatch,NSData *data,NSString *durationTime))videoBlock;
/**
 通过资源获取图片的数据
 
 @param mAsset 资源文件
 @param imageBlock 图片数据回传
 */
+ (void)SB_FetchImageDataFromPHAsset:(PHAsset*)mAsset imageBlock:(void(^)(NSData* data,NSString *filename))imageBlock;
/**
   创建相册
*/
+(BOOL)SB_FetchCreatePHAssetCollection:(NSString *)phtoname;

@end

NS_ASSUME_NONNULL_END
