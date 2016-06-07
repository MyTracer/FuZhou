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

@interface SelectViewController ()<UITextFieldDelegate, STPickerAreaDelegate, STPickerSingleDelegate, STPickerDateDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textArea;
@property (weak, nonatomic) IBOutlet UITextField *textSingle;
@property (weak, nonatomic) IBOutlet UITextField *textDate;
@end

@implementation SelectViewController

#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textArea.delegate = self;
    self.textSingle.delegate = self;
    self.textDate.delegate = self;
    
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
        for (int i = 1; i < 1000; i++) {
            NSString *string = [NSString stringWithFormat:@"%d", i];
            [arrayData addObject:string];
        }
        
        STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
        [pickerSingle setArrayData:arrayData];
        [pickerSingle setTitle:@"请选择价格"];
        [pickerSingle setTitleUnit:@"人民币"];
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
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.textArea.text = text;
}

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    NSString *text = [NSString stringWithFormat:@"%@ 人民币", selectedTitle];
    self.textSingle.text = text;
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%ld年%ld月%ld日", (long)year, (long)month, (long)day];
    self.textDate.text = text;
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
