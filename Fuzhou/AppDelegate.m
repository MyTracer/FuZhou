//
//  AppDelegate.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/28.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"

@interface AppDelegate ()
@property(nonatomic,strong)AFNetworkReachabilityManager *reachabilityManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//     用户登录验证
    /*
     1.读取本地文件
     2.验证用户
     */
    [[UserInfo sharedUserInfo] loadUserInfoFormSandbox];
    
    if (![UserInfo sharedUserInfo].loginStatus) {
#pragma mark - 判断用户名密码正确性（服务器）
        // 已登录，进入主页
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = storyboard.instantiateInitialViewController;
        NSLog(@"进入主页窗口");
    } else {
        // 登录窗口
        NSLog(@"进入登录窗口");
    }
    
//     监听网络状态
    //创建网络监控对象
    self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    
    //设置监听
    [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"不可达的网络(未连接)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                break;
            default:
                break;
        }
    }];
    //开始监听网络状况.
    [_reachabilityManager startMonitoring];
    
    
//     注册通知
    
    // Override point for customization after application launch.
    return YES;
}

-(void)dealloc{
    //停止监听网络状况.
    [_reachabilityManager stopMonitoring];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
