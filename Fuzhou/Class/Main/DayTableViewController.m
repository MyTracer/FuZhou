//
//  DayTableViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/29.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "DayTableViewController.h"
#import "SearchCellTableViewCell.h"
#import "WorkDataModel.h"
#import "DayDetailTableViewController.h"
#import "AFNetworking.h"
#import "SelectViewController.h"
#import "UserInfo.h"
#import "MBProgressHUD.h"
#import "SDRefresh.h"
#import "AppDelegate.h"
#import "JPUSHService.h"


@interface DayTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbPositon;
@property (weak, nonatomic) IBOutlet UILabel *lbProgress;



@property (nonatomic,strong)MBProgressHUD *hud;

@property (nonatomic,strong)SDRefreshHeaderView *refreshHeader;
@end

@implementation DayTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//     初始数据
    NSDate *pickerDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)]; // 获取时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; // 时间格式器
    [pickerFormatter setDateFormat:@"yyyyMMdd"];
    // 时间昨天
    NSString *yesterday = [pickerFormatter stringFromDate:pickerDate];
    // 通知传值
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    self.idStr =  app.idStr==nil?@"02020003":app.idStr;
    self.dateStr = app.dateStr==nil?yesterday:app.dateStr;
    NSLog(@"%@,%@",self.idStr,self.dateStr);
    [self login];
    
    //默认【下拉刷新】
    self.refreshHeader = [SDRefreshHeaderView refreshView];
    [self.refreshHeader addToScrollView:self.tableView];

    [self.refreshHeader addTarget:self refreshAction:@selector(getrefesh)];
}
// 下拉刷新
- (void)getrefesh{
    [self getData];
    [self.refreshHeader endRefreshing];
}

- (void)getData{
    
    NSString *url =@"http://112.124.30.42:8686/api/Progress/GetRileiDetail";
    NSRange rang = NSMakeRange(6, 2);
    if ([[self.dateStr substringWithRange:rang ] isEqualToString:@"00"]) {
        NSLog(@"月进度");
        url = @"http://112.124.30.42:8686/api/Progress/GetYueleiDetail";
    }
    
    // 加载等待
    
    
    [self.hud hideAnimated:YES];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //     请求的manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSDictionary *parameter = @{@"date":self.dateStr,@"id":self.idStr};
    /*
     * desc  : 提交POST请求
     * param :  URLString - 请求地址
     *          parameters - 请求参数
     *          success - 请求成功回调的block
     *          failure - 请求失败回调的block
     */
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSArray *responseObject) {
        
        self.workData = [WorkDataModel workDatawithArray:responseObject];
//        NSLog(@"%d",self.workData.count);
        [self.tableView reloadData];
        // 加载完毕，取消提示
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.hud hideAnimated:YES];
            });
        });
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self tellBackwithText:@"加载出错" withPic:@"Checkmark"];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.workData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *ID = @"SearchCell";// 重用标示
    SearchCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 获取cell，并设置进度条
        cell = [SearchCellTableViewCell initSearchCell];
        //[cell addProgresswithTotal:10 withComplete:2];
        // 设置右侧箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    WorkDataModel *m = self.workData[indexPath.row];
//    设置具体内容
    cell.lbProgress.text= [NSString stringWithFormat:@"%@/%@",m.kl_wcsw,m.sg_sjsw];
    cell.lbPosition.text = m.temp_pname;
    
    //自动折行设置
    cell.lbPosition.numberOfLines = 0;

    
    [cell addProgresswithTotal:100 withComplete:[m.baifenbi floatValue]*100];
    
    
    // Configure the cell...
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取信息
    WorkDataModel *detail = self.workData[indexPath.row];
    //进入聊天详情
    [self performSegueWithIdentifier:@"DaySegue" sender:detail];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destVc = segue.destinationViewController;
    if ([destVc isKindOfClass:[DayDetailTableViewController class]]) {
        DayDetailTableViewController *DayDataVc= destVc;
        DayDataVc.detailData = sender;
    }
    if ([destVc isKindOfClass:[SelectViewController class]]) {
        SelectViewController *DayDataVc= destVc;
        // 拿到block传的值
        [DayDataVc returnText:^(NSString *idtext,NSString *datetext) {
            NSLog(@"%@ %@",idtext,datetext);
            if (![idtext isEqualToString:@" "]&&![datetext isEqualToString:@" "]) {
                NSLog(@"可以赋值");
                self.idStr = idtext;
                self.dateStr = datetext;
            }
        }];
    }
}

// day/month选择切换事件
- (IBAction)segment:(UISegmentedControl *)sender {
    
    NSDate *pickerDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)]; // 获取时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; // 时间格式器
    [pickerFormatter setDateFormat:@"yyyyMMdd"];
    // 时间昨天
    NSString *yesterday = [pickerFormatter stringFromDate:pickerDate];
    NSUInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            // 改为昨天
            self.dateStr = yesterday;
            break;
        case 1:
            self.dateStr = [[self.dateStr substringToIndex:6] stringByAppendingString:@"00"];
            break;
        default:
            break;
    }
    [self getData];
}

// 判断用户
- (void)login{
    
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    //     请求的manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSDictionary *parameter = @{@"lgn":userInfo.user,@"pwd":userInfo.pwd};
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
        NSLog(@"进入登录窗口");
        [self tellBackwithText:@"信息错误" withPic:@"Checkmark"];
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSSet *set = [NSSet setWithArray:@[@""]];
                [JPUSHService setTags:set aliasInbackground:@""];
                [self enterLoginPage];
            });
        });
        
    }];
    
}
- (void)loginwith:(NSDictionary *)response{
    
    UserInfo *userinfo = [UserInfo sharedUserInfo];
    
    //    userinfo.userId = [NSString stringWithFormat:@"%@",response[@"userId"] ];
    userinfo.userId = response[@"userId"];
    userinfo.loginStatus = YES;
    userinfo.userName = response[@"userName"];
    userinfo.departName = response[@"department"];
    userinfo.dutyName = response[@"dutyName"];
    userinfo.cellPhone = response[@"cellPhone"];
    userinfo.roleName = response[@"roleName"];
    
    NSLog(@"%@",userinfo.userId);
    if ([userinfo.userId isEqualToString:@""]) {
        
        NSLog(@"进入登录窗口");
        [self tellBackwithText:@"信息错误" withPic:@"Checkmark"];
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSSet *set = [NSSet setWithArray:@[@""]];
                [JPUSHService setTags:set aliasInbackground:@""];
                [self enterLoginPage];
                
            });
        });
    }else{
        NSLog(@"登录成功");
        [userinfo saveUserInfoToSandbox];
        NSSet *set = [NSSet setWithArray:@[userinfo.userId]];
        [JPUSHService setTags:set aliasInbackground:@""];
        
        
        // 请求plist-三级联动
        [self getPlist];
    }
    
}
- (void)getPlist{
    
    UserInfo *userinfo = [UserInfo sharedUserInfo];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSDictionary *parameter = @{@"ryid":userinfo.userId};
    /*
     * desc  : 提交POST请求
     * param :  URLString - 请求地址
     *          parameters - 请求参数
     *          success - 请求成功回调的block
     *          failure - 请求失败回调的block
     */
    userinfo.sanji = @[@{@"cities":@[@{@"city":@"全部",@"areas":@[@"全部"]}],@"state":@"全部，"}];
    [manager GET:@"http://112.124.30.42:8686/api/Progress/GetPlist" parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSArray *responseObject) {
//        NSLog(@"%@",responseObject);
        NSLog(@"请求成功");
        if(responseObject != nil)
        {
            userinfo.sanji = responseObject;
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
}

// 跳转登录
- (void)enterLoginPage
{
    // 隐藏模态窗口
    [self dismissViewControllerAnimated:NO completion:nil];
    // 来到主界面,切换至主线程
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    self.view.window.rootViewController = storyboard.instantiateInitialViewController;
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self getData];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.hud hideAnimated:YES];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    if([JPUSHService setBadge:0])
    {
        NSLog(@"清零成功");
    }
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
        self.hud .square = YES;
        // Optional label text.
        self.hud.label.text = NSLocalizedString(text, @"HUD done title");
        
        [self.hud hideAnimated:YES afterDelay:1.f];
    });
}

@end
