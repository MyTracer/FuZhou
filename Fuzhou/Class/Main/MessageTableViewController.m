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

@interface MessageTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lbPositon;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;

@property (nonatomic,copy) NSString *startStr;
@property (nonatomic,copy) NSString *endStr;
@end

@implementation MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 测试数据
    self.startStr = @"20160601";
    self.endStr = @"20160610";
}

- (void)getData{
    // 请求参数
    
    
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
    [manager GET:@"http://192.168.195.43:2683/api/Push/GetPishiHistoryByDate" parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSArray *responseObject) {
        
        self.messageData = [MessageDataModel messageDatawithArray:responseObject];
        // NSLog(@"%d",self.messageData.count);
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
    NSLog(@"视图即将显示");
}

@end
