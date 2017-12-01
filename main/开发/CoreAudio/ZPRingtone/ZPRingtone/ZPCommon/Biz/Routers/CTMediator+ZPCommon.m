//
//  CTMediator+ZPCommon.m
//  ZPRingtone
//
//  Created by zhoupanpan on 2017/11/28.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "CTMediator+ZPCommon.h"

@implementation CTMediator (ZPCommon)
+ (void)zpPushViewCtrl:(UIViewController*)viewController animated:(BOOL)animated{
    UINavigationController * rootNavi =(UINavigationController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    if(rootNavi && [NSStringFromClass([rootNavi class]) isEqualToString:@"ZPNavigationController"]){
        [rootNavi pushViewController:viewController animated:animated];
    }
}
@end
