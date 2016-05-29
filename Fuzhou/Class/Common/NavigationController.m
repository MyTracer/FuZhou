//
//  NavigationController.m
//  WeChat
//
//  Created by 韩江鹏 on 16/3/21.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "NavigationController.h"

@implementation NavigationController

+ (void)initialize
{
    
}
+ (void)setupNavTheme
{
    // 导航栏的样式
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置导航条背景(高度不会拉伸,宽度会拉伸)
    [navBar setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置字体
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:dict];
    
    // 设置状态栏样式(Plist里设置 控制器的状态栏不由导航控制器设置)
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

@end
