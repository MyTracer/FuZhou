//
//  SelectViewController.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/30.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "SelectViewController.h"

#import "STPickerArea.h"
#import "STPickerSingle.h"
#import "STPickerDate.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"

@interface SelectViewController ()<UITextFieldDelegate, STPickerAreaDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textArea;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Segmodel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;


@property (nonatomic,copy) NSString *idStr;
@property (nonatomic,copy) NSString *dateStr;

@property (nonatomic,strong)MBProgressHUD *hud;

@end

@implementation SelectViewController
// block
- (void)returnText:(returnTextBlock)textBlock
{
    self.returnTextBlock = textBlock;
}
- (IBAction)okbtnClick:(UIBarButtonItem *)sender {
    if ([self.textArea.text isEqualToString:@""]) {
        [self tellBackwithText:@"确认条件" withPic:@"Checkmark"];
    }else{
        // 提取时间
        NSDate *pickerDate = [self.datepicker date]; // 获取时间
        NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init]; // 时间格式器
        [pickerFormatter setDateFormat:@"yyyyMMdd"];
        self.dateStr = [pickerFormatter stringFromDate:pickerDate];
        // 判断模式
        if (self.Segmodel.selectedSegmentIndex == 1) {
            self.dateStr = [[self.dateStr substringToIndex:6] stringByAppendingString:@"00"];
        }
        // 返回参数
        self.returnTextBlock(self.idStr,self.dateStr);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)cancelbtnClick:(id)sender {
    self.returnTextBlock(@" ",@" ");
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textArea.delegate = self;
    
    self.dateStr = nil;
    self.idStr = nil;
}


#pragma mark - --- delegate 视图委托 ---

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.textArea) {
        [self.textArea resignFirstResponder];
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeCenter];
        [pickerArea show];
    }
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@,%@,%@", province, city, area];
    
    self.textArea.text = text;
    
    self.idStr = [[area componentsSeparatedByString:@","]firstObject];
    
}

#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- getters and setters 属性 ---


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
