//
//  IMXAudioFileManager.m
//  ZPRingtone
//
//  Created by zhoupan on 2017/12/3.
//  Copyright © 2017年 zhoupan. All rights reserved.
//

#import "IMXAudioFileManager.h"
#import <Masonry/Masonry.h>

@interface IMXAudioFileManager()<EZAudioPlayerDelegate>
@property (nonatomic,copy) imx_audio_posBlock posBlock;
@end

@implementation IMXAudioFileManager
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark ======  public  ======
/**
 播放文件并展示效果
 
 @param fileURL 路径
 @param block 回调
 */
- (void)playAudioFile:(NSURL *)fileURL postionBlock:(imx_audio_posBlock)block{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error){
        return;
    }
    [session setActive:YES error:&error];
    if (error){
        return;
    }
    [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
    if (error)
    {
        NSLog(@"Error overriding output to the speaker: %@", error.localizedDescription);
    }
    if(!fileURL){
        return;
    }
    self.posBlock = block;
    self.audioFile = [EZAudioFile audioFileWithURL:fileURL];
    [self.audioPlayer setAudioFile:self.audioFile];
}
//拖拽至特定播放位置
- (void)startPlayPosition:(CGFloat)posi{
    if(!self.audioFile){
        return;
    }
    posi = MAX(posi, 0);
    posi = MIN(posi,self.audioFile.totalFrames);
    [self.audioPlayer seekToFrame:(SInt64)posi];
}
//播放和停止
- (void)play{
    if([self.audioPlayer isPlaying]){
        return;
    }
    [self.audioPlayer play];
}
- (void)stop{
    if(![self.audioPlayer isPlaying]){
        return;
    }
    [self.audioPlayer pause];
}
#pragma mark ======  life cycle  ======
- (instancetype)init{
    self = [super init];
    if (self) {
        [self observeAudioNotifications];
    }
    return self;
}
#pragma mark ======  delegate  ======
- (void)  audioPlayer:(EZAudioPlayer *)audioPlayer
          playedAudio:(float **)buffer
       withBufferSize:(UInt32)bufferSize
 withNumberOfChannels:(UInt32)numberOfChannels
          inAudioFile:(EZAudioFile *)audioFile
{
//    weakify(self);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        strongify(self);
//    });
}
- (void)audioPlayer:(EZAudioPlayer *)audioPlayer
    updatedPosition:(SInt64)framePosition
        inAudioFile:(EZAudioFile *)audioFile
{
    weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        strongify(self);
        if (self.posBlock)
        {
            self.posBlock(framePosition,audioFile.totalFrames);
        }
    });
}
#pragma mark ======  event  ======
- (void)audioPlayerDidChangeAudioFile:(NSNotification *)notification
{
    EZAudioPlayer *player = [notification object];
    NSLog(@"Player changed audio file: %@", [player audioFile]);
}
- (void)audioPlayerDidChangeOutputDevice:(NSNotification *)notification
{
    EZAudioPlayer *player = [notification object];
    NSLog(@"Player changed output device: %@", [player device]);
}
- (void)audioPlayerDidChangePlayState:(NSNotification *)notification
{
    EZAudioPlayer *player = [notification object];
    NSLog(@"Player change play state, isPlaying: %i", [player isPlaying]);
}
#pragma mark ======  private  ======
- (void)observeAudioNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioPlayerDidChangeAudioFile:)
                                                 name:EZAudioPlayerDidChangeAudioFileNotification
                                               object:self.audioPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioPlayerDidChangeOutputDevice:)
                                                 name:EZAudioPlayerDidChangeOutputDeviceNotification
                                               object:self.audioPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioPlayerDidChangePlayState:)
                                                 name:EZAudioPlayerDidChangePlayStateNotification
                                               object:self.audioPlayer];
}
#pragma mark ======  getter & setter  ======
- (void)setPlayVolumn:(CGFloat)playVolume{
    _playVolume = playVolume;
    [self.audioPlayer setVolume:_playVolume];
}
- (EZAudioPlayer *)audioPlayer{
    if(!_audioPlayer){
        _audioPlayer = [EZAudioPlayer audioPlayerWithDelegate:self];
        _audioPlayer.shouldLoop = NO;
    }
    return _audioPlayer;
}

@end

