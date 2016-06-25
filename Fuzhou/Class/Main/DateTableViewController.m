//
//  DateTableViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "DateTableViewController.h"
#import "DateDataModel.h"
#import "DateTableViewCell.h"
#import "DateDetailTableViewController.h"
#import "AFNetworking.h"
#import "DateSelectViewController.h"
#import "MBProgressHUD.h"
#import "SDRefresh.h"

@interface DateTableViewController ()

@property (nonatomic,copy) NSString *modelStr;
@property (nonatomic,copy) NSString *startStr;
@property (nonatomic,copy) NSString *endStr;


@property (nonatomic,strong)MBProgressHUD *hud;

@property (nonatomic,strong)SDRefreshHeaderView *refreshHeader;


@end

@implementation DateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //     初始数据
    NSDate *pickerDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60*10)]; // 获取时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; // 时间格式器
    [pickerFormatter setDateFormat:@"yyyyMMdd"];
    // 过去时间
    NSString *passday = [pickerFormatter stringFromDate:pickerDate];
    self.startStr = passday;
    self.endStr = [pickerFormatter stringFromDate:[NSDate date]];
    self.modelStr = @"day";
    
    
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
    NSString *url =@"http://112.124.30.42:8686/api/Progress/GetSchedule1";
    
    // 加载等待
    
    
    [self.hud hideAnimated:YES];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //     请求的manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSDictionary *parameter = @{@"start":self.startStr,@"end":self.endStr};
    /*
     * desc  : 提交POST请求
     * param :  URLString - 请求地址
     *          parameters - 请求参数
     *          success - 请求成功回调的block
     *          failure - 请求失败回调的block
     */
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSArray *responseObject) {
        
        self.dateData = [DateDataModel dateDatawithArray:responseObject];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *ID = @"DateCell";// 重用标示
    DateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 获取cell，并设置进度条
        cell = [DateTableViewCell initDateCell];
        //[cell addProgresswithTotal:10 withComplete:2];
        // 设置右侧箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    DateDataModel *m = self.dateData[indexPath.row];
    //    设置具体内容
    cell.lbtitle.text= m.title;
    cell.lbcount.text = [NSString stringWithFormat:@"更新了%@条",m.count];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取信息
    DateDataModel *detail = self.dateData[indexPath.row];
    //进入聊天详情
    [self performSegueWithIdentifier:@"DateSegue" sender:detail.date];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destVc = segue.destinationViewController;
    if ([destVc isKindOfClass:[DateDetailTableViewController class]]) {
        DateDetailTableViewController *DayDataVc= destVc;
        DayDataVc.date = sender;
    }
    if ([destVc isKindOfClass:[DateSelectViewController class]]) {
        DateSelectViewController *DayDataVc= destVc;
        // 拿到block传的值
        [DayDataVc returnText:^(NSString *modeltext,NSString *datetext) {
            NSLog(@"%@ %@",modeltext,datetext);
            if (![modeltext isEqualToString:@" "]&&![datetext isEqualToString:@" "]) {
                NSLog(@"可以赋值");
                self.modelStr = modeltext;
                self.startStr = datetext;
                self.endStr = datetext;
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
