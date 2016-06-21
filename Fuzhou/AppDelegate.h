//
//  AppDelegate.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/28.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "AFNetworking.h"

// 必须信息
static NSString *appKey = @"70d7c2288e68a3c1771bfc2d";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,copy) NSString *idStr;
@property (nonatomic,copy) NSString *dateStr;

@end

