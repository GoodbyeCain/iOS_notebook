//
//  CTMediator+ZPCommon.h
//  DHSeller
//
//  Created by zhoupanpan on 2017/11/28.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import <CTMediator/CTMediator.h>

@interface CTMediator (ZPCommon)

/**
 除了TabBar对应的Ctrls，其它所有的ctrl跳转均基于该跳转操作。
 即从rootNavigation进行push pop

 @param viewController 入栈Ctrl
 @param animated 动画
 */
+ (void)zpPushViewCtrl:(UIViewController*)viewController animated:(BOOL)animated;
@end
