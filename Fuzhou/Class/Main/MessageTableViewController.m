//
//  MessageTableViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/14.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "MessageTableViewController.h"
#import "MessageTableViewCell.h"
#import "MessageDataModel.h"
#import "MessageDetailTableViewController.h"
#import "AFNetworking.h"
#import "MessageSelectViewController.h"
#import "UserInfo.h"
#import "MBProgressHUD.h"
#import "SDRefresh.h"

@interface MessageTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lbPositon;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;

@property (nonatomic,copy) NSString *startStr;
@property (nonatomic,copy) NSString *endStr;

@property (nonatomic,strong)MBProgressHUD *hud;

@property (nonatomic,strong)SDRefreshHeaderView *refreshHeader;

@end

@implementation MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 测试数据
    //     初始数据
    NSDate *pickerDate = [NSDate date]; // 获取时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; // 时间格式器
    [pickerFormatter setDateFormat:@"yyyyMMdd"];
    // 时间月初至今
    NSString *nowday = [pickerFormatter stringFromDate:pickerDate];
    
    self.startStr = [[nowday substringToIndex:6] stringByAppendingString:@"01"];;
    self.endStr = nowday;
    
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
    // 加载等待
    [self.hud hideAnimated:YES];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    //     请求的manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSDictionary *parameter = @{@"ryid":[UserInfo sharedUserInfo].userId,@"start":self.startStr,@"end":self.endStr};
    /*
     * desc  : 提交POST请求
     * param :  URLString - 请求地址
     *          parameters - 请求参数
     *          success - 请求成功回调的block
     *          failure - 请求失败回调的block
     */
    [manager GET:@"http://112.124.30.42:8686/api/Push/GetPishiHistoryByDate" parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSArray *responseObject) {
        
        self.messageData = [MessageDataModel messageDatawithArray:responseObject];
        // NSLog(@"%d",self.messageData.count);
        [self.tableView reloadData];
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
    return self.messageData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *ID = @"MessageCell";// 重用标示
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 获取cell，并设置进度条
        cell = [MessageTableViewCell initMessageCell];
        //[cell addProgresswithTotal:10 withComplete:2];
        // 设置右侧箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    MessageDataModel *m = self.messageData[indexPath.row];
    //    设置具体内容
    cell.lbTime.text= m.date;
    cell.lbPosition.text = m.bdname;
    
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取信息
    MessageDataModel *detail = self.messageData[indexPath.row];
    //进入聊天详情
    [self performSegueWithIdentifier:@"MessageSegue" sender:detail];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destVc = segue.destinationViewController;
    if ([destVc isKindOfClass:[MessageDetailTableViewController class]]) {
        MessageDetailTableViewController *DayDataVc= destVc;
        DayDataVc.detailData = sender;
    }
    if ([destVc isKindOfClass:[MessageSelectViewController class]]) {
        MessageSelectViewController *DayDataVc= destVc;
        // 拿到block传的值
        [DayDataVc returnText:^(NSString *startDateStr,NSString *endDateStr) {
            NSLog(@"%@ %@",startDateStr,endDateStr);
            if (![startDateStr isEqualToString:@" "]&&![endDateStr isEqualToString:@" "]) {
                NSLog(@"可以赋值");
                self.startStr = startDateStr;
                self.endStr = endDateStr;
            }
        }];
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
