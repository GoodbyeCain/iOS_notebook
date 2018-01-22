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
@interface ZPHomeViewController ()
@property (nonatomic,strong)IMXAudioFileManager *audioManager;
@property (nonatomic,strong)FDWaveformView *waveView;
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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TchaikovskyExample2" ofType:@"m4a"];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"jingmeng" withExtension:@"mp3"];//[[NSURL alloc] initFileURLWithPath:path];
    self.waveView.audioURL = url;
//    [self.audioManager playAudioFile:url postionBlock:^(CGFloat pos, CGFloat max) {
//        
//    }];
//    [self.audioManager play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======  delegate  ======

#pragma mark ======  event  ======

#pragma mark ======  private  ======

#pragma mark ======  getter & setter  ======
- (IMXAudioFileManager *)audioManager{
    if(!_audioManager){
        _audioManager = [[IMXAudioFileManager alloc] initWithBaseView:self.view plot:CGRectMake(20, 120, 400, 200)];
    }
    return _audioManager;
}
- (FDWaveformView *)waveView{
    if(!_waveView){
        _waveView = [[FDWaveformView alloc] initWithFrame:CGRectMake(20, 200, IMX_SCREEN_WIDTH_UIKIT-40, 400)];
    }
    return _waveView;
}
@end
