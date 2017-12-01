//
//  IMXTabBarViewController.h
//  IMXTabbarKit
//
//  Created by zhoupanpan on 2017/11/27.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMXTabBarViewController : UITabBarController
@property (nonatomic,assign,getter=isBaseOnNavi)BOOL baseOnNavi;
@property (nonatomic,assign)NSUInteger imxSelectedIndex;

- (void)refreshTabBar:(NSArray *)itemModels;
- (void)hideTabBar:(BOOL)isHidden;

- (void)showReddotAtIndex:(NSUInteger)index;
- (void)hideReddotAtIndex:(NSUInteger)index;
@end
