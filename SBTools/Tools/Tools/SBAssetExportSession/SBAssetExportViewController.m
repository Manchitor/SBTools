//
//  SBAssetExportViewController.m
//  Tools
//  视频压缩
//  Created by 刘永吉 on 2023/2/21.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBAssetExportViewController.h"
#import "SBAssetExportSession.h"
#import "SBAssetExportCompression.h"

@interface SBAssetExportViewController ()<SBAssetExportSessionDelegate>

@end

@implementation SBAssetExportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.
    [self assetReaderWriterExport];
    
    //2.
    [self assetExportSession];
    
}

#pragma mark ----------采用 AVAssetReader和AVAssetWriter 实现逐帧压缩(优点是压缩的定制化比较好, 可以设置导出视频的编码格式,比特率, 帧率, 尺寸及视频质量, 压缩之后的画质令人满意, 缺点是视频时长较长时, 压缩时间较长)
-(void)assetReaderWriterExport{
    //1.准备资源文件
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL URLWithString:@""]];
    NSURL *outPath = [NSURL fileURLWithPath:@""];
    
    
    //2.重新编码 防止压缩失败 ->http://events.jianshu.io/p/bf78570995e1
    AVMutableComposition *mainComposition = [[AVMutableComposition alloc] init];
    AVMutableCompositionTrack *compositionVideoTrack = [mainComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
                
    int timeScale = 100000;
    Float64 seconds = CMTimeGetSeconds([asset duration]) - 0.001;
    NSUInteger videoDurationI = (NSUInteger) (seconds * timeScale);
    CMTime videoDuration = CMTimeMake(videoDurationI, timeScale);
    CMTimeRange videoTimeRange = CMTimeRangeMake(kCMTimeZero, videoDuration);
                
    NSArray<AVAssetTrack *> *videoTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    AVAssetTrack *videoTrack = [videoTracks objectAtIndex:0];

    [compositionVideoTrack insertTimeRange:videoTimeRange ofTrack:videoTrack atTime:kCMTimeZero error:nil];
    
    
    //3.初始化压缩参数
    SBAssetExportSession *encoder = [SBAssetExportSession exportSessionWithAsset:mainComposition preset:SBAssetExportSessionPreset480P];
    encoder.delegate = self;
    encoder.outputFileType = AVFileTypeMPEG4;
    encoder.outputURL = outPath;

    NSLog(@"The compressed file size is about %.2fMB", encoder.estimatedExportSize/1000.0);

    
    //4.开始压缩
    [encoder exportAsynchronouslyWithCompletionHandler:^{
        if (encoder.status == AVAssetExportSessionStatusCompleted){
            
            NSLog(@"Video export succeeded. video path:%@", encoder.outputURL);
            NSLog(@"video size:%.2fMB", [self sb_fileSize:encoder.outputURL.relativePath]/1024.0/1024.0);
        }else if (encoder.status == AVAssetExportSessionStatusCancelled){
            NSLog(@"Video export cancelled");
        }else{
            NSLog(@"Video export failed with error: %@ (%ld)", encoder.error.localizedDescription, (long)encoder.error.code);
        }
    }];
}


#pragma mark ----------采用 AVAssetExportSession(优点是压缩快, 能有效的减少视频的文件大小, 但是定制化不友好, 压缩之后的视频画质确实令人不太满意)
-(void)assetExportSession{
    
    [SBAssetExportCompression AVAssetExportSessionWithAsset:@""];
}


//文件大小计算
- (u_int64_t)sb_fileSize:(NSString *)path{
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

@end
