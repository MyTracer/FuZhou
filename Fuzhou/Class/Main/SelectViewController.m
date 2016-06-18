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

@interface SelectViewController ()<UITextFieldDelegate, STPickerAreaDelegate, STPickerSingleDelegate, STPickerDateDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textArea;
@property (weak, nonatomic) IBOutlet UITextField *textSingle;
@property (weak, nonatomic) IBOutlet UITextField *textDate;
@property (weak, nonatomic) IBOutlet UITextView *textAll;

@property (nonatomic,copy) NSString *idStr;
@property (nonatomic,copy) NSString *dateStr;

@end

@implementation SelectViewController
// block
- (void)returnText:(returnTextBlock)textBlock
{
    self.returnTextBlock = textBlock;
}
- (IBAction)okbtnClick:(UIBarButtonItem *)sender {
    if ([self.textArea.text isEqualToString:@""]||[self.textSingle.text isEqualToString:@""]||[self.textDate.text isEqualToString:@""]) {
        NSLog(@"请选择条件");
    }else{
        if ([self.textSingle.text isEqualToString:@"月"]) {
            self.dateStr = [[self.dateStr substringToIndex:6] stringByAppendingString:@"00"];
        }
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
    self.textSingle.delegate = self;
    self.textDate.delegate = self;
    
    self.textAll.layer.borderColor = UIColor.grayColor.CGColor;
    self.textAll.layer.borderWidth = 5;
    
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
    
    if (textField == self.textSingle) {
        [self.textSingle resignFirstResponder];
        
        NSMutableArray *arrayData = [NSMutableArray array];
//        for (int i = 1; i < 1000; i++) {
//            NSString *string = [NSString stringWithFormat:@"%d", i];
//            [arrayData addObject:string];
//        }
        [arrayData addObject:[NSString stringWithFormat:@"天"]];
        [arrayData addObject:[NSString stringWithFormat:@"月"]];
        
        STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
        [pickerSingle setArrayData:arrayData];
        [pickerSingle setTitle:@"请选择查询模式"];
        [pickerSingle setTitleUnit:@""];
        [pickerSingle setContentMode:STPickerContentModeCenter];
        [pickerSingle setDelegate:self];
        [pickerSingle show];
    }
    
    
    if (textField == self.textDate) {
        [self.textDate resignFirstResponder];
        
        STPickerDate *pickerDate = [[STPickerDate alloc]init];
        [pickerDate setDelegate:self];
        [pickerDate show];
    }
    
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@,%@,%@", province, city, area];
    
    self.textArea.text = text;
    [self filltextAll];
    
    self.idStr = [[area componentsSeparatedByString:@","]firstObject];
    
}

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    NSString *text = [NSString stringWithFormat:@"%@", selectedTitle];
    self.textSingle.text = text;
    
    [self filltextAll];
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *strmonth = (month%10 == month)?[NSString stringWithFormat:@"0%ld",(long)month]:[NSString stringWithFormat:@"%ld",(long)month];
    NSString *strday = (day%10 == day)?[NSString stringWithFormat:@"0%ld",(long)day]:[NSString stringWithFormat:@"%ld",(long)day ];
    NSString *text = [NSString stringWithFormat:@"%ld-%@-%@", (long)year, strmonth, strday];
//    NSString *text = [NSString stringWithFormat:@"%ld年%ld月%ld日", (long)year, (long)month, (long)day];
    self.textDate.text = text;
    
    [self filltextAll];
    
    self.dateStr = [self.textDate.text stringByReplacingOccurrencesOfString: @"-" withString: @""];
}

- (void)filltextAll{
    NSString *textStr = @"提示：请确认选择内容。\n\n";
    textStr = [textStr stringByAppendingString:@"  区段：\n\n"];
    if (![self.textArea.text isEqualToString:@""]) {
        NSString *temp = [self.textArea.text stringByReplacingOccurrencesOfString: @"," withString: @"\n"];
        textStr = [textStr stringByAppendingString:temp];
    }
    textStr = [textStr stringByAppendingString:@"\n"];
    
    textStr = [textStr stringByAppendingString:@"  时间：\n\n"];
    if (![self.textDate.text isEqualToString:@""]) {
        NSString *temp = [self.textDate.text stringByReplacingOccurrencesOfString: @"," withString: @"-"];
        textStr = [textStr stringByAppendingString:temp];
    }
    textStr = [textStr stringByAppendingString:@"\n"];
    
    textStr = [textStr stringByAppendingString:@"  模式：\n\n"];
    if (![self.textSingle.text isEqualToString:@""]) {
        NSString *temp = [self.textSingle.text stringByReplacingOccurrencesOfString: @"," withString: @"\n"];
        textStr = [textStr stringByAppendingString:temp];
    }
    textStr = [textStr stringByAppendingString:@"\n"];
    
    self.textAll.text = textStr;
}
#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- getters and setters 属性 ---


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
