//
//  ZPSTabBarViewController.m
//  IMXTabbarKit
//
//  Created by zhoupanpan on 2017/11/27.
//  Copyright © 2017年 panzhow. All rights reserved.
//

#import "ZPSTabBarViewController.h"
@interface ZPSTabBarViewController ()
@property (nonatomic,strong)NSArray *items;
@end

@implementation ZPSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"ZPSTabbarConfigs" withExtension:@"plist"];
    NSArray *itemsArray = [[NSArray alloc] initWithContentsOfURL:url];
    NSMutableArray *tmpItems = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in itemsArray) {
        @autoreleasepool{
            IMXTabbarItemModel *model = [IMXTabbarItemModel new];
            model.selected = [[dic objectForKey:@"selected"] boolValue];
            model.itemImg = [UIImage imageNamed:[dic objectForKey:@"itemImg"]];
            model.itemSelectedImg = [UIImage imageNamed:[dic objectForKey:@"itemSelectedImg"]];
            model.itemTitle = [dic objectForKey:@"itemTitle"];
            model.pageClass = [dic objectForKey:@"pageClass"];
            model.rootNavi = [dic objectForKey:@"rootNavi"];
            [tmpItems addObject:model];
        }
    }
    self.items = tmpItems;
    
    [self refreshTabBar:self.items];
    self.imxSelectedIndex = 1;
    [self showReddotAtIndex:2];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}


@end
