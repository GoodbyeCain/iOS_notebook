//
//  IMXAudioFileManager.h
//  ZPRingtone
//
//  Created by zhoupan on 2017/12/4.
//  Copyright © 2017年 zhoupan. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^imx_audio_posBlock)(CGFloat pos,CGFloat max);

@interface IMXAudioFileManager : NSObject

/**
 图表长度
 */
@property (nonatomic,assign)CGFloat plotLength;
//声音
@property (nonatomic,assign)CGFloat playVolume;
@property (nonatomic,strong)UIColor *plotBackColor;
@property (nonatomic,strong)UIColor *plotColor;

- (instancetype)initWithBaseView:(UIView *)baseView plot:(CGRect)frame;
- (void)playAudioFile:(NSURL *)fileURL postionBlock:(imx_audio_posBlock)block;
- (void)startPlayPosition:(CGFloat)posi;

- (void)play;
- (void)stop;
@end

