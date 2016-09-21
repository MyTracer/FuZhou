//
//  AppDelegate.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/28.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "JPUSHService.h"

@interface AppDelegate ()
@property(nonatomic,strong)AFNetworkReachabilityManager *reachabilityManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
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
    // 权限请求
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound |
//                                                          UIUserNotificationTypeAlert)
//                                              categories:nil];
//    } else {
//        //categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    // 图标
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    if([JPUSHService setBadge:0])
    {
        NSLog(@"清零成功");
    }
    //     用户登录验证
    /*
     1.读取本地文件
     2.验证用户
     */
    [[UserInfo sharedUserInfo] loadUserInfoFormSandbox];
    if ([UserInfo sharedUserInfo].loginStatus == YES) {
        //        判断用户名密码正确性（服务器）主页中判断
        // 已登录，进入主页
        [self enterMainPage];
        return YES;
    } else {
        // 登录窗口
        NSLog(@"进入登录窗口");
    }
    
    // Override point for customization after application launch.
    return YES;
}



// 进入主页
- (void)enterMainPage{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.rootViewController = storyboard.instantiateInitialViewController;
    NSLog(@"进入主页窗口");
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
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    // Required -    DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"收到通知:%@", [self logDic:userInfo]);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
//    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    self.idStr = userInfo[@"id"];
    self.dateStr = userInfo[@"date"];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    if([JPUSHService setBadge:0])
    {
        NSLog(@"清零成功");
        
    }
    
    [self enterMainPage];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
//- (NSString *)logDic:(NSDictionary *)dic {
//    if (![dic count]) {
//        return nil;
//    }
//    NSString *tempStr1 =
//    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
//                                                 withString:@"\\U"];
//    NSString *tempStr2 =
//    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString *tempStr3 =
//    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *str =
//    [NSPropertyListSerialization propertyListFromData:tempData
//                                     mutabilityOption:NSPropertyListImmutable
//                                               format:NULL
//                                     errorDescription:NULL];
//    return str;
//}

@end
