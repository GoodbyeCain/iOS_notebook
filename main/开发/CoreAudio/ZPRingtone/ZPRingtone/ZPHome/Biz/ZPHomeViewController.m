//
//  DHHomeViewController.m
//  ZPRingtone
//
//  Created by zhoupanpan on 2017/11/28.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "ZPHomeViewController.h"
#import "ZPRingtone-Swift.h"
#import "IMXAudioFileManager.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>
#import "IMXClipView.h"

@interface ZPHomeViewController ()
@property (nonatomic,strong)IMXAudioFileManager *audioManager;
@property (nonatomic,strong)IMXWaveFormManager *waveformManager;
@property (nonatomic,strong)UILabel *infoLB;
@property (nonatomic,strong)IMXClipView *clipView;
@property (nonatomic,strong)IMXAudioClipManager*clipManager;
@end

@implementation ZPHomeViewController

- (void)dealloc{
}
#pragma mark ======  public  ======

#pragma mark ======  life cycle  ======
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.waveView];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self configUIs];
    [self refreshUIs];
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"jingmeng" ofType:@"caf"];
    NSString *sandBoxPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接录音文件绝对路径
    NSString * path = [sandBoxPath stringByAppendingPathComponent:@"filetest.m4a"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    
    [self.waveformManager loadAudioWithAudio:url];
    
    weakify(self);
    [self.audioManager playAudioFile:url postionBlock:^(CGFloat pos, CGFloat max) {
        strongify(self);
         CGFloat percent = pos/max*100.0;
         [self.waveformManager highlightWaveformWithPercent:percent];
        self.infoLB.text = [NSString stringWithFormat:@"%@/%@",self.audioManager.audioPlayer.audioFile.formattedCurrentTime,self.audioManager.audioPlayer.audioFile.formattedDuration];
    }];
    [self.audioManager play];
    
    self.clipView.totalTime = self.audioManager.audioPlayer.audioFile.duration;
    self.clipView.maxTime = 40;
    self.clipView.defaultTime = 15;
    self.clipView.endPanBlock = ^(NSTimeInterval start, NSTimeInterval end) {
        strongify(self);
        NSTimeInterval currentTime = self.audioManager.audioPlayer.currentTime;
        if(currentTime < start || currentTime > end){
            self.audioManager.audioPlayer.currentTime = start;
        }        
        [self.audioManager play];
        [self.audioManager stop];
        
        [self.clipManager imxconvertFileWithFile:url tofileName:@"filetest" retblock:^(AKAudioFile * _Nullable file, NSError * _Nullable error) {
            NSLog(@"---%@",file);
            
            [self.audioManager play];
        }];
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======  delegate  ======

#pragma mark ======  event  ======

#pragma mark ======  private  ======
- (void)configUIs{
    [self.view addSubview:self.infoLB];
    [self.view addSubview:self.clipView];
}
- (void)refreshUIs{
    [self.infoLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.waveformManager.waveform.mas_bottom).offset(10);
        make.width.mas_equalTo(44);
    }];
    [self.clipView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.waveformManager.waveform).offset(0);
        make.right.equalTo(self.waveformManager.waveform).offset(0);
        make.top.equalTo(self.waveformManager.waveform).offset(0);
        make.height.mas_equalTo(60+40);
    }];
}
#pragma mark ======  getter & setter  ======
- (IMXAudioFileManager *)audioManager{
    if(!_audioManager){
        _audioManager = [[IMXAudioFileManager alloc] init];
    }
    return _audioManager;
}
- (FDWaveformView *)waveView{
    if(!_waveView){
        _waveView = [[FDWaveformView alloc] initWithFrame:CGRectMake(20, 200, IMX_SCREEN_WIDTH_UIKIT-40, 400)];
    }
    return _waveView
}
- (IMXWaveFormManager *)waveformManager{
    if(!_waveformManager){
        _waveformManager = [[IMXWaveFormManager alloc] initWithWaveFrame:CGRectMake(20, 200, IMX_SCREEN_WIDTH_UIKIT-40, 60) baseView:self.view waveColor:[UIColor grayColor] proColor:[UIColor darkGrayColor]];
        _waveformManager.linerWave = NO;
    }
    return _waveformManager;
}
- (UILabel *)infoLB{
    if(!_infoLB){
        _infoLB = [UILabel new];
        _infoLB.textAlignment = NSTextAlignmentRight;
    }
    return _infoLB;
}
- (IMXClipView *)clipView{
    if(!_clipView){
        _clipView = [[IMXClipView alloc] init];
    }
    return _clipView;
}
- (IMXAudioClipManager *)clipManager{
    if(!_clipManager){
        _clipManager = [[IMXAudioClipManager alloc] init];
    }
    return _clipManager;
}
@end
