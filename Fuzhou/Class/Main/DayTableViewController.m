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

@interface DayTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbPositon;
@property (weak, nonatomic) IBOutlet UILabel *lbProgress;

@property (nonatomic,copy) NSString *idStr;
@property (nonatomic,copy) NSString *dateStr;

@property (nonatomic,strong)MBProgressHUD *hud;

@end

@implementation DayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 测试数据
    self.idStr = @"02020003";
    self.dateStr = @"20160601";
    //[self login];
    
//    UITabBar *myTb=self.tabBarController.tabBar;
//    for(UITabBarItem *utb in myTb.items)
//    {
//        if( ![utb.title isEqualToString:@"个人资料"] )
//        {
//            utb.enabled=NO;
//        }
//        else {
//            utb.enabled=YES;
//            self.tabBarController.selectedIndex=0;
//        }
//    }
}

- (void)getData{
    // 请求参数
    
    
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
    [manager GET:@"http://192.168.195.43:2683/api/Progress/GetRileiDetail" parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSArray *responseObject) {
        
        self.workData = [WorkDataModel workDatawithArray:responseObject];
//        NSLog(@"%d",self.workData.count);
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
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
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self getData];
    NSLog(@"视图即将显示");
}
// day/month选择切换事件
- (IBAction)segment:(UISegmentedControl *)sender {
    NSUInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            // 改为今天
            self.dateStr = [[self.dateStr substringToIndex:6] stringByAppendingString:@"01"];
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
    [manager GET:@"http://192.168.195.43:2683/api/User/GetLogin" parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        [self loginwith:responseObject];
        NSLog(@"请求成功");
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"进入登录窗口");
        [self enterLoginPage];
    }];
    
}
- (void)loginwith:(NSDictionary *)response{
    
    UserInfo *userinfo = [UserInfo sharedUserInfo];
    
    //    userinfo.userId = [NSString stringWithFormat:@"%@",response[@"userId"] ];
    userinfo.userId = response[@"userId"];
    userinfo.loginStatus = YES;
    userinfo.userName = response[@"userName"];
    userinfo.departName = response[@"departName"];
    userinfo.dutyName = response[@"dutyName"];
    userinfo.cellPhone = response[@"cellPhone"];
    userinfo.roleName = response[@"roleName"];
    
    NSLog(@"%@",userinfo.userId);
    if ([userinfo.userId isEqualToString:@""]) {
        NSLog(@"error");
        NSLog(@"进入登录窗口");
        [self enterLoginPage];
    }else{
        [userinfo saveUserInfoToSandbox];
        
    }
    
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

@end
