//
//  LoginViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/9.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfo.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

#import "NSString+Hash.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
@property (nonatomic,strong)MBProgressHUD *hud;

@end

@implementation LoginViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)loginbtnClick:(id)sender {
    [self.view endEditing:YES];
    // 请求参数
    NSString *lgn =  self.user.text;
    NSString *pwd = [self.pwd.text md5String];
    if ([lgn isEqualToString:@""]||[pwd isEqualToString:@""]) {
        NSLog(@"请输入完整信息");
    }else
    {
   
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
        [self login];
    }
    
    
}

- (void)login{
    // 请求参数
    NSString *lgn =  self.user.text;
    NSString *pwd = [self.pwd.text md5String];
    //     请求的manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSDictionary *parameter = @{@"lgn":lgn,@"pwd":pwd};
    /*
     * desc  : 提交POST请求
     * param :  URLString - 请求地址
     *          parameters - 请求参数
     *          success - 请求成功回调的block
     *          failure - 请求失败回调的block
     */
    [manager GET:@"http://192.168.195.43:2683/api/User/GetLogin" parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        [self loginwith:responseObject];
        NSLog(@"请求成功");
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.hud hideAnimated:YES];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            // Set the custom view mode to show any view.
            hud.mode = MBProgressHUDModeCustomView;
            // Set an image view with a checkmark.
            UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            hud.customView = [[UIImageView alloc] initWithImage:image];
            // Looks a bit nicer if we make it square.
            hud.square = YES;
            // Optional label text.
            hud.label.text = NSLocalizedString(@"Done", @"HUD done title");
            
            [hud hideAnimated:YES afterDelay:3.f];
        });
    }];
}

- (void)loginwith:(NSDictionary *)response{
    // NSLog(@"%@",response);
    
    UserInfo *userinfo = [UserInfo sharedUserInfo];
    userinfo.user = self.user.text;
    userinfo.pwd = self.pwd.text;
//    userinfo.userId = [NSString stringWithFormat:@"%@",response[@"userId"] ];
    userinfo.userId = response[@"userId"];
    userinfo.loginStatus = YES;
    userinfo.userName = response[@"userName"];
    userinfo.departName = response[@"departName"];
    userinfo.dutyName = response[@"dutyName"];
    userinfo.cellPhone = response[@"cellPhone"];
    userinfo.roleName = response[@"roleName"];
    if (![userinfo.userId isEqualToString:@""])
    {
        [userinfo saveUserInfoToSandbox];
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
               
                [self enterMainPage];
            });
            
            
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.hud hideAnimated:YES];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            // Set the custom view mode to show any view.
            hud.mode = MBProgressHUDModeCustomView;
            // Set an image view with a checkmark.
            UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            hud.customView = [[UIImageView alloc] initWithImage:image];
            // Looks a bit nicer if we make it square.
            hud.square = YES;
            // Optional label text.
            hud.label.text = NSLocalizedString(@"请重新确认", @"HUD done title");
            
            [hud hideAnimated:YES afterDelay:3.f];
        });
    }
    
}
// 跳转主页
- (void)enterMainPage
{
    // 隐藏模态窗口
    [self dismissViewControllerAnimated:NO completion:nil];
    // 来到主界面,切换至主线程
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     self.view.window.rootViewController = storyboard.instantiateInitialViewController;
    
    
}
- (IBAction)cancelbtnClick:(id)sender {
    [self.view endEditing:YES];
    self.user.text = nil;
    self.pwd.text = nil;
}
// 按钮可用状态
- (IBAction)userEdit:(id)sender {
    if ((self.user.text != nil) && (self.user.text != nil)) {
        self.loginbtn.enabled = true;
    }else
    {
        self.loginbtn.enabled = false;
    }
}
- (IBAction)pwdEdit:(id)sender {
    if ((self.user.text != nil) && (self.user.text != nil)) {
        self.loginbtn.enabled = true;
    }else
    {
        self.loginbtn.enabled = false;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.hud hideAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
