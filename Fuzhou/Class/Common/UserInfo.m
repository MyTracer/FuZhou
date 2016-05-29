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



@implementation UserInfo
singleton_implementation(UserInfo)

- (void)saveUserInfoToSandbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults setBool:self.loginStatus forKey:LoginStatusKey];
    [defaults synchronize];
}
- (void)loadUserInfoFormSandbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.pwd = [defaults objectForKey:PwdKey];
    self.loginStatus = [defaults boolForKey:LoginStatusKey];
}
-(NSString *)jid
{
    return [NSString stringWithFormat:@"%@@%@",self.user,domain];
}
@end
