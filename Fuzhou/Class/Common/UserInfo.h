//
//  UserInfo.h
//  WeChat
//
//  Created by 韩江鹏 on 16/3/21.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
static NSString *domain = @"teacher.local";
@interface UserInfo : NSObject
singleton_interface(UserInfo);
@property (nonatomic,copy) NSString *user;
@property (nonatomic,copy) NSString *pwd;
// 登录状态
@property (nonatomic,assign) BOOL loginStatus;

@property (nonatomic,copy) NSString *registerUser;
@property (nonatomic,copy) NSString *registerPwd;

@property (nonatomic,copy) NSString *jid;
// 保存数据到沙盒
- (void)saveUserInfoToSandbox;
// 获取沙盒数据
- (void)loadUserInfoFormSandbox;
@end
