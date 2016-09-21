//
//  UserInfo.m
//  WeChat
//
//  Created by 韩江鹏 on 16/3/21.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "UserInfo.h"


#define UserKey @"user"
#define PwdKey @"pwd"
#define LoginStatusKey @"loginStatus"
#define UserIdKey @"userId"

#define UserNameKey @"userName"
#define DepartNameKey @"departName"
#define DutyNameKey @"dutyName"
#define CellPhoneKey @"cellPhone"
#define RoleNameKey @"roleName"




@implementation UserInfo
singleton_implementation(UserInfo)

- (void)saveUserInfoToSandbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults setBool:self.loginStatus forKey:LoginStatusKey];
//    [defaults setObject:self.userId forKey:UserIdKey];
//    [defaults setObject:self.userName forKey:UserNameKey];
//    [defaults setObject:self.departName forKey:DepartNameKey];
//    [defaults setObject:self.dutyName forKey:DutyNameKey];
//    [defaults setObject:self.cellPhone forKey:CellPhoneKey];
//    [defaults setObject:self.roleName forKey:RoleNameKey];
    [defaults synchronize];
}
- (void)loadUserInfoFormSandbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.pwd = [defaults objectForKey:PwdKey];
    self.loginStatus = [defaults boolForKey:LoginStatusKey];
    
//    self.userId = [defaults objectForKey:UserIdKey];
//    self.userName = [defaults objectForKey:UserNameKey];
//    self.departName = [defaults objectForKey:DepartNameKey];
//    self.dutyName = [defaults objectForKey:DutyNameKey];
//    self.cellPhone = [defaults objectForKey:CellPhoneKey];
//    self.roleName = [defaults objectForKey:RoleNameKey];
}



@end
