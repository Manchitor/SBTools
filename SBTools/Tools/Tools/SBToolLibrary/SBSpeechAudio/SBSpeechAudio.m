//
//  SBSpeechAudio.m
//  Tools
//
//  Created by 刘永吉 on 2023/4/18.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "SBSpeechAudio.h"

@interface SBSpeechAudio ()<SFSpeechRecognizerDelegate,AVSpeechSynthesizerDelegate>

@end

@implementation SBSpeechAudio
///创建单例对象
+ (SBSpeechAudio *)shareSpeechAudio{
    static SBSpeechAudio *speechAudio = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        speechAudio = [[SBSpeechAudio alloc] init];
    });
    
    return speechAudio;
}

#pragma mark ----------开始录音
- (void)sb_speech_audio_start_record:(SBSpeechResultTextCallback)callback{
    //1.0
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord mode:AVAudioSessionModeMeasurement options:AVAudioSessionCategoryOptionDuckOthers error:nil];
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    
    //2.0
    SB_WEAKSEKF;
    self.recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:self.recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        BOOL isFinal = NO;
        NSString *bestResult = [[result bestTranscription] formattedString];
        isFinal = result.isFinal;
        if (error || isFinal) {
            [weakSelf sb_speech_audio_stop_record];
            NSLog(@"error:%@",error.localizedDescription);
        } else {
            NSLog(@"-----%@", bestResult);
            if (callback) {
                callback(bestResult);
            }
        }
    }];
    
    //3.0
    AVAudioFormat *recordingFormat = [[self.audioEngine inputNode] outputFormatForBus:0];
    [[self.audioEngine inputNode] installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [weakSelf.recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    
    [self.audioEngine prepare];
    
    NSError *startError = nil;
    [self.audioEngine startAndReturnError:&startError];
}

#pragma mark ----------停止录音
- (void)sb_speech_audio_stop_record{
    [[self.audioEngine inputNode] removeTapOnBus:0];
    [self.audioEngine stop];
    [self.recognitionRequest endAudio];
    _recognitionRequest = nil;
    _recognitionTask = nil;
}

#pragma mark ----------朗读
- (void)sb_speech_audio_speaker_text:(NSString *)text {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord mode:AVAudioSessionModeMeasurement options:AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    
    //初始化要说出的内容
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:text];
    //设置语速,语速介于AVSpeechUtteranceMaximumSpeechRate和AVSpeechUtteranceMinimumSpeechRate之间
    //AVSpeechUtteranceMaximumSpeechRate
    //AVSpeechUtteranceMinimumSpeechRate
    //AVSpeechUtteranceDefaultSpeechRate
    utterance.rate = 0.5;
 
    //设置音高,[0.5 - 2] 默认 = 1
    //AVSpeechUtteranceMaximumSpeechRate
    //AVSpeechUtteranceMinimumSpeechRate
    //AVSpeechUtteranceDefaultSpeechRate
    utterance.pitchMultiplier = 1;
 
    //设置音量,[0-1] 默认 = 1
    utterance.volume = 1;
 
    //读一段前的停顿时间
    utterance.preUtteranceDelay = 0.1;
    //读完一段后的停顿时间
    utterance.postUtteranceDelay = 0.2;
 
    //设置声音,是AVSpeechSynthesisVoice对象
    //AVSpeechSynthesisVoice定义了一系列的声音, 主要是不同的语言和地区.
    //voiceWithLanguage: 根据制定的语言, 获得一个声音.
    //speechVoices: 获得当前设备支持的声音
    //currentLanguageCode: 获得当前声音的语言字符串, 比如”ZH-cn”
    //language: 获得当前的语言
    //通过特定的语言获得声音
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    //通过voicce标示获得声音
    //AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithIdentifier:AVSpeechSynthesisVoiceIdentifierAlex];
    utterance.voice = voice;
    //开始朗读
    [self.avSpeaker speakUtterance:utterance];
}

//请求任务过程中的监听方法
#pragma mark ----------- SFSpeechRecognitionTaskDelegate
//当开始检测音频源中的语音时首先调用此方法
-(void)speechRecognitionDidDetectSpeech:(SFSpeechRecognitionTask *)task
{
  
}
//当识别出一条可用的信息后 会调用
/*     需要注意，apple的语音识别服务会根据提供的音频源识别出多个可能的结果 每有一条结果可用 都会调用此方法 */
-(void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didHypothesizeTranscription:(SFTranscription *)transcription
{
   
}
//当识别完成所有可用的结果后调用
- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishRecognition:(SFSpeechRecognitionResult *)recognitionResult
{
    
}
//当不再接受音频输入时调用 即开始处理语音识别任务时调用
- (void)speechRecognitionTaskFinishedReadingAudio:(SFSpeechRecognitionTask *)task
{
 
}
//当语音识别任务被取消时调用
- (void)speechRecognitionTaskWasCancelled:(SFSpeechRecognitionTask *)task
{
    
}
//语音识别任务完成时被调用
- (void)speechRecognitionTask:(SFSpeechRecognitionTask *)task didFinishSuccessfully:(BOOL)successfully
{

}


#pragma mark ---------- AVSpeechSynthesizerDelegate
//已经开始
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
 
}
//已经说完
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
 
    //如果朗读要循环朗读，可以在这里再次调用朗读方法
    //[_avSpeaker speakUtterance:utterance];
}
//已经暂停
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
 
}
//已经继续说话
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
 
}
//已经取消说话
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
 
}
//将要说某段话
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
 
}

#pragma mark ----------权限申请判断
-(void)sb_speech_audio_request_authorization:(SBSpeechAuthorizationCallback)callback{
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        BOOL isAuthorized = NO;
        switch (status) {
                //结果未知 用户尚未进行选择
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                isAuthorized = NO;
                break;
                //用户拒绝授权语音识别
            case SFSpeechRecognizerAuthorizationStatusDenied:
                isAuthorized = NO;
                break;
                //设备不支持语音识别功能
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                isAuthorized = NO;
                break;
                //用户授权语音识别
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                isAuthorized = YES;
                break;
                
            default:
                break;
        }
        
        if (callback) {
            callback(isAuthorized, status);
        }
    }];
}


#pragma mark ----------懒加载
- (AVAudioEngine *)audioEngine{
    if (!_audioEngine) {
        _audioEngine = [[AVAudioEngine alloc] init];
    }
    return _audioEngine;
}
- (SFSpeechRecognizer *)speechRecognizer{
    if (!_speechRecognizer) {
        _speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:self.locale];
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}

-(NSLocale *)locale{
    if (!_locale) {
        // 中文 zh-CN      英文 en-US
        _locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    }
    return _locale;
}

-(SFSpeechAudioBufferRecognitionRequest *)recognitionRequest{
    if (!_recognitionRequest) {
        _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
        // 实时返回
        _recognitionRequest.shouldReportPartialResults = YES;
    }
    return _recognitionRequest;
}

-(AVSpeechSynthesizer *)avSpeaker{
    if (!_avSpeaker) {
        //初始化语音合成器
        _avSpeaker = [[AVSpeechSynthesizer alloc] init];
        _avSpeaker.delegate = self;
    }
    return _avSpeaker;
}

-(void)dealloc{
    NSLog(@"SBSpeechAudio---->dealloc");
}
@end
