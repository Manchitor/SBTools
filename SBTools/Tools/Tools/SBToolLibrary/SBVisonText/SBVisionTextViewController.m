//
//  SBVisionTextViewController.m
//  Tools
//
//  Created by 刘永吉 on 2023/4/19.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBVisionTextViewController.h"
#import "SBVisionText.h"

@interface SBVisionTextViewController ()

@end

@implementation SBVisionTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)getText:(UIButton *)sender {
    [self getTextFormImage:[UIImage imageNamed:@"1681888102373.jpg"]];
}

-(void)getTextFormImage:(UIImage *)img{
    if (@available(iOS 11.0, *)) {
        [SBVisionText sb_vision_text_image:img result:^(NSError * _Nonnull error, NSArray<__kindof VNObservation *> * _Nonnull results) {
            if (@available(iOS 13.0, *)) {
                for (VNRecognizedTextObservation *observation in results) {
                    NSLog(@"%@", [observation topCandidates:1].firstObject.string);
                }
            } else {
                NSLog(@"Fallback on earlier versions");
            }
           
        }];
    } else {
        NSLog(@"Fallback on earlier versions");
    }
    return;
}
@end
