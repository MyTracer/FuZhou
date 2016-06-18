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
@property (nonatomic,copy) NSString *lgntext;
@property (nonatomic,copy) NSString *pwdtext;

@end

@implementation LoginViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)loginbtnClick:(id)sender {
    [self.view endEditing:YES];
    // 请求参数
    self.lgntext =  [self.user.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.pwdtext = [[self.pwd.text md5String] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([self.lgntext isEqualToString:@""]||[self.pwdtext isEqualToString:@""]||[self.pwdtext isEqualToString:@"d41d8cd98f00b204e9800998ecf8427e"]) {
        [self tellBackwithText:@"请填写完整" withPic:@"Checkmark"];
    }else
    {
   
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self login];
    }
    
    
}

- (void)login{
    
    //     请求的manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSDictionary *parameter = @{@"lgn":self.lgntext,@"pwd":self.pwdtext};
    /*
     * desc  : 提交POST请求
     * param :  URLString - 请求地址
     *          parameters - 请求参数
     *          success - 请求成功回调的block
     *          failure - 请求失败回调的block
     */
    [manager GET:@"http://112.124.30.42:8686/api/User/GetLogin" parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        [self loginwith:responseObject];
        NSLog(@"请求成功");
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"请求失败");
        [self tellBackwithText:@"请求失败" withPic:@"Checkmark"];
    }];
}

- (void)loginwith:(NSDictionary *)response{
    // NSLog(@"%@",response);
    
    UserInfo *userinfo = [UserInfo sharedUserInfo];
    userinfo.user = self.lgntext;
    userinfo.pwd = self.pwdtext;
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
                [self.hud hideAnimated:YES];
               
                [self enterMainPage];
            });
            
            
        });
    }
    else
    {
        [self tellBackwithText:@"信息错误" withPic:@"Checkmark"];
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
//    视图消失时，取消
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
// 相关提示
- (void)tellBackwithText:(NSString *)text withPic:(NSString *)pic{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the custom view mode to show any view.
        self.hud.mode = MBProgressHUDModeCustomView;
        // Set an image view with a checkmark.
        UIImage *image = [[UIImage imageNamed:pic] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.hud.customView = [[UIImageView alloc] initWithImage:image];
        // Looks a bit nicer if we make it square.
        self.hud.square = YES;
        // Optional label text.
        self.hud.label.text = NSLocalizedString(text, @"HUD done title");
        
        [self.hud hideAnimated:YES afterDelay:1.f];
    });
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
