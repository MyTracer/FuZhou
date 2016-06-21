//
//  UserInfo.h
//  WeChat
//
//  Created by 韩江鹏 on 16/3/21.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface UserInfo : NSObject
singleton_interface(UserInfo);
@property (nonatomic,copy) NSString *user; // 登录名
@property (nonatomic,copy) NSString *pwd;  // 密码
// 登录状态
@property (nonatomic,assign) BOOL loginStatus;
@property (nonatomic,copy) NSString *userId;

@property (nonatomic,copy) NSString *userName; // 用户名
@property (nonatomic,copy) NSString *departName; // 部门
@property (nonatomic,copy) NSString *dutyName; // 职务
@property (nonatomic,copy) NSString *cellPhone; // 手机号码
@property (nonatomic,copy) NSString *roleName; // 角色
@property (nonatomic,strong) NSArray *sanji; // 三级信息


// 保存数据到沙盒
- (void)saveUserInfoToSandbox;
// 获取沙盒数据
- (void)loadUserInfoFormSandbox;


@end
