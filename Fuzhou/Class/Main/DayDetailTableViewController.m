//
//  DayDetailTableViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/10.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "DayDetailTableViewController.h"
#import "WorkDataModel.h"
#import "LHEditTextView.h"
#import "AFNetworking.h"
#import "UserInfo.h"

@interface DayDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbtemp_pname;
@property (weak, nonatomic) IBOutlet UILabel *lbsg_unit;
@property (weak, nonatomic) IBOutlet UILabel *lbriqi;
@property (weak, nonatomic) IBOutlet UILabel *lbsg_sjsw;
@property (weak, nonatomic) IBOutlet UILabel *lbsg_sjcz;
@property (weak, nonatomic) IBOutlet UILabel *lbdw_dwcsw;
@property (weak, nonatomic) IBOutlet UILabel *lbdw_dwccz;
@property (weak, nonatomic) IBOutlet UILabel *lbkl_wcsw;
@property (weak, nonatomic) IBOutlet UILabel *lbks_wccz;
@property (weak, nonatomic) IBOutlet UILabel *lbtemp_pname1;
@property (weak, nonatomic) IBOutlet UILabel *lbtemp_pname2;
@property (weak, nonatomic) IBOutlet UILabel *lbtemp_pname3;
@property (weak, nonatomic) IBOutlet UITextView *tvinfonote;
@property (weak, nonatomic) IBOutlet UITextView *tvremark;
@property (nonatomic,copy) NSString *userid;
@property (nonatomic,copy) NSString *tempid;
@property (nonatomic,copy) NSString *date;

@end

@implementation DayDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtemp_pname.text = self.detailData.temp_pname;
    self.lbtemp_pname1.text = self.detailData.temp_pname1;
    self.lbtemp_pname2.text = self.detailData.temp_pname2;
    self.lbtemp_pname3.text = self.detailData.temp_pname3;
    self.lbsg_unit.text = self.detailData.sg_unit;
    self.lbriqi.text = self.detailData.riqi;
    self.lbsg_sjsw.text = self.detailData.sg_sjsw;
    self.lbsg_sjcz.text = self.detailData.sg_sjcz;
    self.lbdw_dwcsw.text = self.detailData.dw_dwcsw;
    self.lbdw_dwccz.text = self.detailData.dw_dwccz;
    self.lbkl_wcsw.text = self.detailData.kl_wcsw;
    self.lbks_wccz.text = self.detailData.ks_wccz;
    
    self.tvinfonote.text = self.detailData.infonote;
    self.tvremark.text = self.detailData.remark;
    
    self.userid = [UserInfo sharedUserInfo].userId;
    self.tempid = [self.detailData.temp_bdid stringByAppendingString:self.detailData.temp_pid];
    self.date = self.detailData.riqi;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"1");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 批示
- (IBAction)CallBack:(UIButton *)sender {
    [LHEditTextView showWithController:self andRequestDataBlock:^(NSString *text) {
        NSLog(@"%@",text);
        if (![text isEqualToString:@""]) {
            [self backdatawithText:text];
        }
        
    }];
}

- (void)backdatawithText:(NSString *)text{
    // 请求参数
    NSDate *pickerDate = [NSDate date]; // 获取时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; // 时间格式器
    [pickerFormatter setDateFormat:@"yyyyMMddHHmm"];
    
    NSString *createTime = [pickerFormatter stringFromDate:pickerDate];
    
    
    //     请求的manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.f;
    NSDictionary *parameter = @{@"ryid":self.userid,@"id":self.tempid,@"date":self.date,@"creatTime":createTime,@"content":text};
    /*
     * desc  : 提交POST请求
     * param :  URLString - 请求地址
     *          parameters - 请求参数
     *          success - 请求成功回调的block
     *          failure - 请求失败回调的block
     */
    [manager GET:@"http://192.168.195.43:2683/api/Comment/GetComment" parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        
        NSString *result = responseObject[@"state"];
        if ([result isEqualToString:@"1"]) {
            NSLog(@"保存成功");
        }else
        {
            NSLog(@"保存失败");
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}



@end
