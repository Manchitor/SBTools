//
//  ViewController.m
//  Tools
//
//  Created by 刘永吉 on 2020/8/5.
//  Copyright © 2020 lyj. All rights reserved.
//

#import "ViewController.h"
#import "SBToolsHeader.h"
#import "SBAssetExportSession.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
}

-(void)aa{
    AVURLAsset *asset = [AVURLAsset assetWithURL:@""];
    
    NSURL *outPath = [NSURL fileURLWithPath:@""];
    
    
    SBAssetExportSession *encoder = [SBAssetExportSession exportSessionWithAsset:asset preset:SBAssetExportSessionPreset480P];
    encoder.delegate = self;
    encoder.outputFileType = AVFileTypeMPEG4;
    encoder.outputURL = outPath;

    
//    CMTime time = [asset duration];
//    encoder.timeRange = CMTimeRangeMake(CMTimeMake(0, time.timescale), CMTimeMake(1, time.timescale));
    NSLog(@"The compressed file size is about %.2fMB", encoder.estimatedExportSize/1000.0);

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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *str;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [dic setObject:str forKey:@"ddd"];
    NSLog(@"%@---%@",dic[@"ddd"],dic[@"dddddd"]);
}
@end
