//
//  SBSpeechAudio.h
//  Tools
//
//  Created by 刘永吉 on 2023/4/18.
//  Copyright © 2023 lyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Speech/Speech.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SBSpeechAuthorizationCallback)(BOOL authorized, SFSpeechRecognizerAuthorizationStatus status);
typedef void(^SBSpeechResultTextCallback)(NSString *bestText);


@interface SBSpeechAudio : NSObject

/// 语音引擎，负责提供语音输入
@property (nonatomic, strong) AVAudioEngine         *audioEngine;
///语音识别器
@property (nonatomic, strong) SFSpeechRecognizer    *speechRecognizer;
/// 处理语音识别请求
@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest     *recognitionRequest;
/// 输出语音识别对象的结果
@property (nonatomic, strong) SFSpeechRecognitionTask   *recognitionTask;
///语言类型
@property (nonatomic, strong) NSLocale                  *locale;
///语音播报
@property (nonatomic, strong) AVSpeechSynthesizer       *avSpeaker;

///创建单例对象
+ (SBSpeechAudio *)shareSpeechAudio;

///开始录音
- (void)sb_speech_audio_start_record:(SBSpeechResultTextCallback)callback;

///停止录音
- (void)sb_speech_audio_stop_record;

///朗读
- (void)sb_speech_audio_speaker_text:(NSString *)text;

- (void)sb_speech_audio_request_authorization:(SBSpeechAuthorizationCallback)callback;
@end

NS_ASSUME_NONNULL_END
