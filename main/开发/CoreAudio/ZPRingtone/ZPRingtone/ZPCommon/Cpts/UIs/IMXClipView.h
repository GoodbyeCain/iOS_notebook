//
//  IMXClipView.h
//  ZPRingtone
//
//  Created by zhoupan on 2017/12/6.
//  Copyright © 2017年 zhoupan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^imx_clip_panBlock)(NSTimeInterval start,NSTimeInterval end);

@interface IMXClipView : UIView
@property (nonatomic,assign)NSTimeInterval totalTime;
@property (nonatomic,assign)NSTimeInterval maxTime;
@property (nonatomic,assign)NSTimeInterval defaultTime;

@property (nonatomic,assign,readonly)NSTimeInterval startTime;
@property (nonatomic,assign,readonly)NSTimeInterval endTime;
@property (nonatomic,copy) imx_clip_panBlock endPanBlock;
@end
