//
//  SBAISpeechViewController.m
//  Tools
//
//  Created by 刘永吉 on 2023/4/13.
//

#import "SBAISpeechViewController.h"
#import "SBSpeechAudio.h"

@interface SBAISpeechViewController ()<SFSpeechRecognizerDelegate,AVSpeechSynthesizerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SBAISpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SBSpeechAudio shareSpeechAudio] sb_speech_audio_request_authorization:^(BOOL authorized, SFSpeechRecognizerAuthorizationStatus status) {
    }];
    
}

#pragma mark ----------开始录音
- (IBAction)startRecord:(id)sender {
    SB_WEAKSEKF;
    [[SBSpeechAudio shareSpeechAudio] sb_speech_audio_start_record:^(NSString * _Nonnull bestText) {
        weakSelf.textView.text = bestText;
    }];
}

#pragma mark ----------停止录音
- (IBAction)stopRecord:(id)sender {
    [[SBSpeechAudio shareSpeechAudio] sb_speech_audio_stop_record];
}

#pragma mark ----------朗读
- (IBAction)readText:(id)sender {
    [[SBSpeechAudio shareSpeechAudio] sb_speech_audio_speaker_text:self.textView.text];
}


-(void)dealloc{
    NSLog(@"dealloc");
}
@end
