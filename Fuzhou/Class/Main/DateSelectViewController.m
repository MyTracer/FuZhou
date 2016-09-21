//
//  DateSelectViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "DateSelectViewController.h"
#import "MBProgressHUD.h"

@interface DateSelectViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *Segmodel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;

@property (nonatomic,copy) NSString *modelStr;
@property (nonatomic,copy) NSString *dateStr;

@property (nonatomic,strong)MBProgressHUD *hud;

@end

@implementation DateSelectViewController
// block
- (void)returnText:(returnTextBlock)textBlock
{
    self.returnTextBlock = textBlock;
}
- (IBAction)okbtnClick:(UIBarButtonItem *)sender {
    
    // 提取时间
    NSDate *pickerDate = [self.datepicker date]; // 获取时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; // 时间格式器
    
    // 判断模式
    switch (self.Segmodel.selectedSegmentIndex) {
        case 0:
            self.modelStr = @"day";
            break;
        case 1:
            self.modelStr = @"month";
        case 2:
            self.modelStr = @"week";
        default:
            break;
    }
    // 当天
    if([self.modelStr isEqualToString:@"day"])
    {
        [pickerFormatter setDateFormat:@"yyyyMMdd"];
        self.dateStr = [pickerFormatter stringFromDate:pickerDate];
    }
    // 当月
    if([self.modelStr isEqualToString:@"month"])
    {
        [pickerFormatter setDateFormat:@"yyyyMM"];
        self.dateStr = [pickerFormatter stringFromDate:pickerDate];
        self.dateStr = [self.dateStr stringByAppendingString:@"00"];
        
    }
    // 当周
    if([self.modelStr isEqualToString:@"week"])
    {
        [pickerFormatter setDateFormat:@"yyyyMM"];
        self.dateStr = [pickerFormatter stringFromDate:pickerDate];
        
        self.dateStr = [self.dateStr stringByAppendingString:@"00"];
        
    }
    
    
    // 返回参数
    self.returnTextBlock(self.modelStr,self.dateStr);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)cancelbtnClick:(id)sender {
    self.returnTextBlock(@" ",@" ");
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.datepicker.maximumDate = [NSDate date];
    
    
    
    self.dateStr = @" ";
    self.modelStr = @" ";
    
    self.datepicker.date = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:YES];
    [self.hud hideAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
// 相关提示
- (void)tellBackwithText:(NSString *)text withPic:(NSString *)pic{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
        self.hud  = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set the custom view mode to show any view.
        self.hud .mode = MBProgressHUDModeCustomView;
        // Set an image view with a checkmark.
        UIImage *image = [[UIImage imageNamed:pic] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.hud .customView = [[UIImageView alloc] initWithImage:image];
        // Looks a bit nicer if we make it square.
        self.hud .square = YES;
        // Optional label text.
        self.hud.label.text = NSLocalizedString(text, @"HUD done title");
        
        [self.hud hideAnimated:YES afterDelay:1.f];
    });
}

@end
