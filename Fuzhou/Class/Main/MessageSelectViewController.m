//
//  MessageSelectViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/16.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "MessageSelectViewController.h"

#import "STPickerDate.h"
#import <QuartzCore/QuartzCore.h>

@interface MessageSelectViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *startSwith;
@property (weak, nonatomic) IBOutlet UISwitch *endSwith;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;

@property (nonatomic,copy) NSString *startDateStr;
@property (nonatomic,copy) NSString *endDateStr;
@end

@implementation MessageSelectViewController
// block
- (void)returnText:(returnTextBlock)textBlock
{
    self.returnTextBlock = textBlock;
}
- (IBAction)okbtnClick:(UIBarButtonItem *)sender {
    if(self.startSwith.isOn)
    {
        NSDate *pickerDate = [self.startDate date]; // 获取时间
        NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; // 时间格式器
        [pickerFormatter setDateFormat:@"yyyyMMdd"];
        
        self.startDateStr = [pickerFormatter stringFromDate:pickerDate];
    }else
    {
        self.startDateStr = @"";
    }
    
    if(self.endSwith.isOn)
    {
        NSDate *pickerDate = [self.endDate date]; // 获取时间
        NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; // 时间格式器
        [pickerFormatter setDateFormat:@"yyyyMMdd"];
        
        self.endDateStr = [pickerFormatter stringFromDate:pickerDate];
    }else
    {
        self.endDateStr = @"";
    }
    
    if ([self.startDateStr isEqualToString:@""]&&[self.endDateStr isEqualToString:@""]) {
        NSLog(@"请选择条件");
    }else{
        if([self.startDateStr isEqualToString:@""])
            self.startDateStr = self.endDateStr;
        if([self.endDateStr isEqualToString:@""])
            self.endDateStr  = self.startDateStr;
        self.returnTextBlock(self.startDateStr,self.endDateStr);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)cancelbtnClick:(id)sender {
    self.returnTextBlock(@" ",@" ");
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 时间选择的显示与隐藏
- (IBAction)startJudge:(UISwitch *)sender {
    self.startDate.hidden = !sender.isOn;
}
- (IBAction)endJudge:(UISwitch *)sender {
    self.endDate.hidden = !sender.isOn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    
    
    self.startDateStr = nil;
    self.endDateStr = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
