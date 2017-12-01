//
//  ZPSTabBarLaunchService.m
//  ZPRingtone
//
//  Created by zhoupanpan on 2017/11/28.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "ZPSTabBarLaunchService.h"
#import "ZPSTabBarViewController.h"
#import "ZPNavigationController.h"
#import "CTMediator+ZPCommon.h"
@implementation ZPSTabBarLaunchService

IMX_EXPORT_SERVICE_High(@"IMX_rootTabBarUI")

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    application.delegate.window = window;

    ZPSTabBarViewController* ctrl = [[ZPSTabBarViewController alloc] init];
    ctrl.view.backgroundColor = [UIColor whiteColor];
    ZPNavigationController* rootNavi = [[ZPNavigationController alloc] initWithRootViewController:ctrl];
    window.rootViewController = rootNavi;
    [window makeKeyAndVisible];
    
    return YES;
}
@end
