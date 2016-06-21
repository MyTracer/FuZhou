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
#import "MBProgressHUD.h"

@interface DayDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbtemp_bdname;
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

@property (nonatomic,strong)MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UILabel *lbshiwu;
@property (weak, nonatomic) IBOutlet UILabel *lbchanliang;
@property (weak, nonatomic) IBOutlet UIButton *btnpishi;
@end

@implementation DayDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtemp_bdname.text = self.detailData.temp_bdname;
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
    self.lbks_wccz.text = self.detailData.kl_wccz;
    
    self.tvinfonote.text = self.detailData.infonote;
    
    self.tvinfonote.contentInset = UIEdgeInsetsMake(8.f, 0.f, -8.f, 0.f);
    self.tvremark.text = self.detailData.remark;
    self.tvremark.contentInset = UIEdgeInsetsMake(8.f, 0.f, -8.f, 0.f);
    
    self.userid = [UserInfo sharedUserInfo].userId;
    self.tempid = [self.detailData.temp_bdid stringByAppendingString:self.detailData.temp_pid];
    self.date = self.detailData.riqi;
    
    NSRange rang = NSMakeRange(6, 2);
    if ([[self.lbriqi.text substringWithRange:rang ]isEqualToString:@"00"]){
        self.lbshiwu.text = @"当月完成实物";
        self.lbchanliang.text = @"当月完成产量";
        self.btnpishi.enabled = false;
    }else
    {
        self.lbshiwu.text = @"当天完成实物";
        self.lbchanliang.text = @"当天完成产量";
        self.btnpishi.enabled = true;
    }
   
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)backdatawithText:(NSString *)text{
    
    // 请求参数
    NSDate *pickerDate = [NSDate date]; // 获取时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; // 时间格式器
    [pickerFormatter setDateFormat:@"yyyyMMddHHmm"];
    
    NSString *createTime = [pickerFormatter stringFromDate:pickerDate];
//
    if (self.userid == nil) {
        NSLog(@"登录问题");
        return;
    }
    // 滚动到顶部
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
    [manager GET:@"http://112.124.30.42:8686/api/Comment/GetComment" parameters:parameter progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        
        NSString *result = responseObject[@"state"];
        NSLog(@"%@",result);
        if ([result isEqualToString:@"1"]) {
            NSLog(@"保存成功");
            [self tellBackwithText:@"保存成功" withPic:@"Checkmark"];
        }else
        {
            [self tellBackwithText:@"保存失败" withPic:@"Checkmark"];
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self tellBackwithText:@"访问出错" withPic:@"Checkmark"];
    }];

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
        self.hud  = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
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


@end
