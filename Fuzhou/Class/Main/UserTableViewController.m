//
//  UserTableViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/11.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "UserTableViewController.h"
#import "UserInfo.h"

@interface UserTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UILabel *userId;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *departName;
@property (weak, nonatomic) IBOutlet UILabel *dutyName;
@property (weak, nonatomic) IBOutlet UILabel *roleName;
@property (weak, nonatomic) IBOutlet UILabel *cellPhone;

@end

@implementation UserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UserInfo *userinfo = [UserInfo sharedUserInfo];
    self.user.text = userinfo.user;
    self.userId.text = userinfo.userId;
    self.userName.text = userinfo.userName;
    self.departName.text = userinfo.departName;
    self.dutyName.text = userinfo.dutyName;
    self.roleName.text = userinfo.roleName;
    self.cellPhone.text = userinfo.cellPhone;
    
}
- (IBAction)userOut:(id)sender {
    [UserInfo sharedUserInfo].loginStatus = false;
    [[UserInfo sharedUserInfo] saveUserInfoToSandbox];
    [self enterMainPage];
}
// 跳转主页
- (void)enterMainPage
{
    // 隐藏模态窗口
    [self dismissViewControllerAnimated:NO completion:nil];
    // 来到主界面,切换至主线程
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    self.view.window.rootViewController = storyboard.instantiateInitialViewController;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
