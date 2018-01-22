//
//  IMXAudioFileManager.h
//  ZPRingtone
//
//  Created by zhoupan on 2017/12/4.
//  Copyright © 2017年 zhoupan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioKit/AudioKit.h>
#import <AudioKitUI/AudioKitUI.h>

typedef void (^imx_audio_posBlock)(CGFloat pos,CGFloat max);

@interface IMXAudioFileManager : NSObject
@property (nonatomic,strong) EZAudioPlayer *audioPlayer;
@property (nonatomic,strong) EZAudioFile * audioFile;

//声音
@property (nonatomic,assign)CGFloat playVolume;

- (void)playAudioFile:(NSURL *)fileURL postionBlock:(imx_audio_posBlock)block;
- (void)startPlayPosition:(CGFloat)posi;

- (void)play;
- (void)stop;
@end

