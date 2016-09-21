//
//  DateDetailTableViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "DateDetailTableViewController.h"
#import "SubTable.h"
#import "DateDetailCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "SDRefresh.h"
#import "DateMoreTableViewController.h"


@interface DateDetailTableViewController ()
@property (nonatomic,strong)NSArray *subData;

@property (nonatomic,strong)MBProgressHUD *hud;

@property (nonatomic,strong)SDRefreshHeaderView *refreshHeader;
@end

@implementation DateDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //默认【下拉刷新】
    self.refreshHeader = [SDRefreshHeaderView refreshView];
    [self.refreshHeader addToScrollView:self.tableView];
    
    [self.refreshHeader addTarget:self refreshAction:@selector(getrefesh)];
    
    [self getData];
}
// 下拉刷新
- (void)getrefesh{
    [self getData];
    [self.refreshHeader endRefreshing];
}

- (void)getData{
    NSString *url =@"http://112.124.30.42:8686/api/Progress/GetSchedule2";
    
    // 加载等待
    
    
    [self.hud hideAnimated:YES];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //     请求的manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSDictionary *parameter = @{@"date":self.date};
    NSLog(@"%@",self.date);
    /*
     * desc  : 提交POST请求
     * param :  URLString - 请求地址
     *          parameters - 请求参数
     *          success - 请求成功回调的block
     *          failure - 请求失败回调的block
     */
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSArray *responseObject) {
        NSLog(@"%@",responseObject);
        self.subData = [SubTable subDatawithArray:responseObject];
        NSLog(@"%@",self.subData);
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subData.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *ID = @"DateDetailCell";// 重用标示
    DateDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 获取cell，并设置进度条
        cell = [DateDetailCell initDateDetailCell];
        //[cell addProgresswithTotal:10 withComplete:2];
        // 设置右侧箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    SubTable *m = self.subData[indexPath.row];
    //    设置具体内容
    cell.lbname.text = m.bdname;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取信息
    SubTable *detail = self.subData[indexPath.row];
    //进入聊天详情
    [self performSegueWithIdentifier:@"DateMoreSegue" sender:detail];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destVc = segue.destinationViewController;
    if ([destVc isKindOfClass:[DateMoreTableViewController class]]) {
        DateMoreTableViewController *DayDataVc= destVc;
        DayDataVc.subData = sender;
    }
   
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
