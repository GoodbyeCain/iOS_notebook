//
//  IMXClipView.m
//  ZPRingtone
//
//  Created by zhoupan on 2017/12/6.
//  Copyright © 2017年 zhoupan. All rights reserved.
//

#import "IMXClipView.h"
#import <Masonry/Masonry.h>

@interface IMXClipView()
@property (nonatomic,strong)UIView *leftMaskView;
@property (nonatomic,strong)UIView *leftLineView;
@property (nonatomic,strong)UILabel *leftTipsLB;
@property (nonatomic,strong)UILabel *leftBottomLB;

@property (nonatomic,strong)UIView *middleMaskView;

@property (nonatomic,strong)UIView *rightMaskView;
@property (nonatomic,strong)UIView *rightLineView;
@property (nonatomic,strong)UILabel *rightTipsLB;
@property (nonatomic,strong)UILabel *rightBottomLB;

@property (nonatomic,assign)NSTimeInterval minTime;

@property (nonatomic,assign)BOOL isFirstLoad;
@property (nonatomic,assign)NSTimeInterval currentMinTime;
@property (nonatomic,assign)NSTimeInterval currentMaxTime;
@end

@implementation IMXClipView

- (void)dealloc{
}
#pragma mark ======  public  ======

#pragma mark ======  life cycle  ======
- (instancetype)init{
    self = [super init];
    if (self) {
        self.maxTime = 40.0;
        self.minTime = 10.0;
        self.backgroundColor = [UIColor clearColor];
        [self configUIs];
        [self refreshUIs];
        self.isFirstLoad = YES;
    }
    return self;
}
#pragma mark ======  delegate  ======

#pragma mark ======  event  ======
- (void)UIDragged:(UIPanGestureRecognizer *)pan{
    static CGFloat leftX=0,rightX=0;
    CGPoint posiPoint = [pan locationInView:self];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            if(pan.view == self.leftBottomLB){
                leftX = posiPoint.x;
            }else{
                rightX = posiPoint.x;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            if(pan.view == self.leftBottomLB){
//                BOOL isLeftMaskTooMax = self.leftMaskView.imxWidth-([self clipWitdh]-[self miniMidlleWidth])>0.1;
//                BOOL isRightMove = posiPoint.x - leftX > 0.1;
//                if(isLeftMaskTooMax && isRightMove){
//                    return;
//                }
                posiPoint = CGPointMake(MIN(posiPoint.x, [self clipWitdh]-[self miniMidlleWidth]), posiPoint.y);
                [self animateLeftUIsLinked2Right:posiPoint.x];
            }else{
//                BOOL isRightMaskTooMax = self.rightMaskView.imxWidth-([self clipWitdh]-[self miniMidlleWidth])>0.1;
//                BOOL isLeftMove = rightX - posiPoint.x > 0.1;
//                if(isRightMaskTooMax && isLeftMove){
//                    return;
//                }
                posiPoint = CGPointMake(MAX(posiPoint.x,[self miniMidlleWidth]), posiPoint.y);
                [self animateRightUIsLinked2Left:posiPoint.x];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{
            if(self.endPanBlock){
                self.endPanBlock(self.currentMinTime, self.currentMaxTime);
            }
        }
        case UIGestureRecognizerStateCancelled:{
//            if(pan.view == self.leftBottomLB){
//                leftX = 0;
//            }else{
//                rightX = 0;
//            }
        }
            break;
        default:
            break;
    }
}
#pragma mark ======  private  ======
- (void)configUIs{
    [self addSubview:self.leftMaskView];
    [self addSubview:self.leftLineView];
    [self addSubview:self.leftTipsLB];
    [self addSubview:self.leftBottomLB];
    
    [self addSubview:self.middleMaskView];
    
    [self addSubview:self.rightMaskView];
    [self addSubview:self.rightLineView];
    [self addSubview:self.rightTipsLB];
    [self addSubview:self.rightBottomLB];
    
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(UIDragged:)];
    self.leftBottomLB.userInteractionEnabled = YES;
    [self.leftBottomLB addGestureRecognizer:leftPan];
    UIPanGestureRecognizer *rightPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(UIDragged:)];
    self.rightBottomLB.userInteractionEnabled = YES;
    [self.rightBottomLB addGestureRecognizer:rightPan];
}
- (void)refreshUIs{
    [self refreshLeftUIs];
    [self refreshRightUIs];
    [self refreshMiddleUIs];
}
//--->
- (void)animateLeftUIsLinked2Right:(CGFloat)posi{
    [self animateLeftUIsFromLeft:posi];
    CGFloat ratio = self.totalTime/[self clipWitdh];
    NSTimeInterval middleTime = self.middleMaskView.imxWidth*ratio;
    
    if(middleTime - self.maxTime > 0.1 ){//middleTime > self.maxTime
        CGFloat rightPosi = posi + self.maxTime*(1.0/ratio);
        [self animateRightUIsFromRight:rightPosi];
    }else if(self.minTime - middleTime > 0.1){//middleTime < self.minTime
        CGFloat rightPosi = posi + self.minTime*(1.0/ratio);
        [self animateRightUIsFromRight:rightPosi];
    }
}
///<----
- (void)animateRightUIsLinked2Left:(CGFloat)posi{
    [self animateRightUIsFromRight:posi];
    CGFloat ratio = self.totalTime/[self clipWitdh];
    NSTimeInterval middleTime = self.middleMaskView.imxWidth*ratio;
    
    if(middleTime - self.maxTime > 0.1 ){
        CGFloat leftPosi = posi - self.maxTime*(1.0/ratio);
        [self animateLeftUIsFromLeft:leftPosi];
    }else if(self.minTime - middleTime > 0.1){
        CGFloat leftPosi = posi - self.minTime*(1.0/ratio);
        [self animateLeftUIsFromLeft:leftPosi];
    }
}
- (CGFloat)clipWitdh{
    return self.imxWidth;
}
#pragma mark ======  funcs  ======
- (void)animateLeftUIsFromLeft:(CGFloat)posi{
    CGFloat leftwidth = posi;
    leftwidth = MAX(0, leftwidth);
    CGFloat ratio = leftwidth/[self clipWitdh];
    
    self.currentMinTime = MAX(self.totalTime*ratio, 0);
    self.leftTipsLB.text = [NSString stringWithFormat:@"%.2d:%.2ld",(int)self.currentMinTime/60,(NSInteger)self.currentMinTime%60];
    
    [self.leftMaskView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(leftwidth);
    }];
}
- (void)animateRightUIsFromRight:(CGFloat)posi{
     CGFloat rightwidth = [self clipWitdh] - posi;
    rightwidth = MAX(0, rightwidth);
    CGFloat ratio = rightwidth/[self clipWitdh];
    
    self.currentMaxTime = MIN(self.totalTime*(1.0-ratio), self.totalTime);
    self.rightTipsLB.text = [NSString stringWithFormat:@"%.2d:%.2ld",(int)self.currentMaxTime/60,(NSInteger)self.currentMaxTime%60];
   
    [self.rightMaskView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rightwidth);
    }];
}

- (CGFloat)miniMidlleWidth{//mini time is 10s
    CGFloat minWidth = [self clipWitdh] * (10.0/self.totalTime);
    return minWidth;
}
- (CGFloat)maxMidlleWidth{
    CGFloat maxWidth = [self clipWitdh] * (self.maxTime/self.totalTime);
    return maxWidth;
}
- (void)refreshLeftUIs{
    [self.leftMaskView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-40);
        make.width.mas_equalTo(0);
    }];
    [self.leftLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftMaskView.mas_right).offset(-0.5);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-40);
        make.width.mas_equalTo(0.5);
    }];
    [self.leftTipsLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.leftMaskView).offset(-0.5).priorityLow();
        make.left.greaterThanOrEqualTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(30);
    }];
    [self.leftBottomLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftLineView).offset(0);
        make.top.equalTo(self.leftMaskView.mas_bottom).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.mas_equalTo(40);
    }];
}
- (void)refreshRightUIs{
    [self.rightMaskView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-40);
        make.width.mas_equalTo(0);
    }];
    [self.rightLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightMaskView.mas_left).offset(0.5);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-40);
        make.width.mas_equalTo(0.5);
    }];
    [self.rightTipsLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightMaskView).offset(0.5).priorityLow();
        make.right.lessThanOrEqualTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(30);
    }];
    [self.rightBottomLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rightLineView).offset(0);
        make.top.equalTo(self.rightMaskView.mas_bottom).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.mas_equalTo(40);
    }];
}
- (void)refreshMiddleUIs{
    [self.middleMaskView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftMaskView.mas_right).offset(0).priorityLow();
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-40);
        make.right.equalTo(self.rightMaskView.mas_left);
    }];
}
#pragma mark ======  getter & setter  ======
- (UIView *)leftMaskView{
    if(!_leftMaskView){
        _leftMaskView = [UIView new];
        _leftMaskView.backgroundColor = [UIColor clearColor];
    }
    return _leftMaskView;
}
- (UIView *)leftLineView{
    if(!_leftLineView){
        _leftLineView = [UIView new];
        _leftLineView.backgroundColor = [UIColor whiteColor];
    }
    return _leftLineView;
}
- (UILabel *)leftTipsLB{
    if(!_leftTipsLB){
        _leftTipsLB = [UILabel new];
        _leftTipsLB.backgroundColor = [UIColor grayColor];
        _leftTipsLB.textColor = [UIColor whiteColor];
        _leftTipsLB.font = [UIFont imx_helNeueFont:8];
    }
    return _leftTipsLB;
}
- (UILabel *)leftBottomLB{
    if(!_leftBottomLB){
        _leftBottomLB = [UILabel new];
        _leftBottomLB.backgroundColor = [UIColor grayColor];
    }
    return _leftBottomLB;
}
- (UIView *)middleMaskView{
    if(!_middleMaskView){
        _middleMaskView = [UIView new];
        _middleMaskView.backgroundColor = [UIColor imxColorWithHex:0x000000 alpha:.4];
    }
    return _middleMaskView;
}
- (UIView *)rightMaskView{
    if(!_rightMaskView){
        _rightMaskView = [UIView new];
        _rightMaskView.backgroundColor = [UIColor clearColor];
    }
    return _rightMaskView;
}
- (UIView *)rightLineView{
    if(!_rightLineView){
        _rightLineView = [UIView new];
        _rightLineView.backgroundColor = [UIColor whiteColor];
    }
    return _rightLineView;
}
- (UILabel *)rightTipsLB{
    if(!_rightTipsLB){
        _rightTipsLB = [UILabel new];
        _rightTipsLB.backgroundColor = [UIColor grayColor];
        _rightTipsLB.textColor = [UIColor whiteColor];
        _rightTipsLB.font = [UIFont imx_helNeueFont:8];
    }
    return _rightTipsLB;
}
- (UILabel *)rightBottomLB{
    if(!_rightBottomLB){
        _rightBottomLB = [UILabel new];
        _rightBottomLB.backgroundColor = [UIColor redColor];
    }
    return _rightBottomLB;
}
- (void)setDefaultTime:(NSTimeInterval)defaultTime{
    if(_defaultTime == defaultTime){
        return;
    }
    _defaultTime = defaultTime;
    CGFloat ratio = self.totalTime/[self clipWitdh];
    CGFloat posi = _defaultTime* (1/ratio);
    posi = MIN(posi, [self clipWitdh]-[self miniMidlleWidth]);
    [self animateLeftUIsLinked2Right:posi];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if(self.isFirstLoad){
        self.defaultTime = 10;
        self.isFirstLoad = NO;
    }
}
- (NSTimeInterval)startTime{
    return [self.leftTipsLB.text doubleValue];
}
- (NSTimeInterval)endTime{
    return [self.rightTipsLB.text doubleValue];
}
@end
