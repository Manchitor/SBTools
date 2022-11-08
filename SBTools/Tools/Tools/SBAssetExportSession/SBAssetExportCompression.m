//
//  SBAssetExportCompression.m
//  Tools
//
//  Created by 刘永吉 on 2022/11/8.
//  Copyright © 2022 lyj. All rights reserved.
//

#import "SBAssetExportCompression.h"
#import <AVFoundation/AVFoundation.h>

@implementation SBAssetExportCompression

+ (void) AVAssetExportSessionWithAsset:(NSString *)videoPath{
    
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    
    AVURLAsset *asset = [AVURLAsset assetWithURL:videoURL];
    
    //设置压缩的格式
    AVAssetExportSession *session=[AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetMediumQuality];//mediumquality:中等质量
    session.videoComposition = [self getVideoComposition:asset];
    //设置导出路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld_compressedVideo.mp4",time(NULL)]];
    //设置到处路径
    session.outputURL=[NSURL fileURLWithPath:path];
    //设置输出文件的类型
    session.outputFileType=AVFileTypeMPEG4;
    //开辟子线程处理耗时操作
    [session exportAsynchronouslyWithCompletionHandler:^{
        NSLog(@"导出完成! 路径:%@",path);
    }];
}

///视频大小及方向修正
+ (AVMutableVideoComposition *)getVideoComposition:(AVAsset *)asset {
    AVAssetTrack *videoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    AVMutableComposition *composition = [AVMutableComposition composition];
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    CGSize videoSize = videoTrack.naturalSize;
    
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if([tracks count] > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGAffineTransform t = videoTrack.preferredTransform;
        if((t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0) ||
           (t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0)){
            videoSize = CGSizeMake(videoSize.height, videoSize.width);
        }
    }
    composition.naturalSize    = videoSize;
    videoComposition.renderSize = videoSize;
    videoComposition.frameDuration = CMTimeMake(1, videoTrack.nominalFrameRate);
    
    AVMutableCompositionTrack *compositionVideoTrack;
    compositionVideoTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration) ofTrack:videoTrack atTime:kCMTimeZero error:nil];
    AVMutableVideoCompositionLayerInstruction *layerInst;
    layerInst = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    [layerInst setTransform:videoTrack.preferredTransform atTime:kCMTimeZero];
    AVMutableVideoCompositionInstruction *inst = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    inst.timeRange = CMTimeRangeMake(kCMTimeZero, asset.duration);
    inst.layerInstructions = [NSArray arrayWithObject:layerInst];
    videoComposition.instructions = [NSArray arrayWithObject:inst];
    return videoComposition;
}
@end
