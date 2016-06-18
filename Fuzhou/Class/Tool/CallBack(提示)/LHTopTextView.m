//
//  LHTopTextView.m
//  LHPopTextView
//
//  Created by 刘旭辉 on 16/4/19.
//  Copyright © 2016年 刘旭辉. All rights reserved.
//

#import "LHTopTextView.h"

@interface LHTopTextView()<UITextViewDelegate>{
    CGFloat _space;
    NSString *_text;
    CGFloat _margin;
}
@end

@implementation LHTopTextView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        //设置两个控件之间的间距
        _space=10.0;
        
        //设置与边框的间距
        _margin=15.0;
        
        //设置圆角
        self.layer.cornerRadius=5;
        [self.layer setMasksToBounds:YES];
        
        //设置背景色
        self.backgroundColor=[UIColor whiteColor];
        
        //驳回申诉
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake((frame.size.width-2*_margin)/3+_margin, _margin,(frame.size.width-2*_margin)/3, (frame.size.height-_margin*2-_space)/7)];
        self.titleLabel=titleLabel;
        [self addSubview:titleLabel];
        [titleLabel setFont:[UIFont systemFontOfSize:20]];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [titleLabel setText:@"批示信息"];
        //输入框
        UITextView *textView=[[UITextView alloc]initWithFrame:CGRectMake(_margin, CGRectGetMaxY(titleLabel.frame)+_space, frame.size.width-2*_margin, CGRectGetHeight(titleLabel.frame)*4)];
        textView.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.739140070921986];
        self.textView=textView;
        textView.font=[UIFont systemFontOfSize:15];
        NSString *str=@"请输入您对处理内容的评价，最多128个字";
        textView.textColor=[UIColor whiteColor];
        textView.text=str;
        textView.returnKeyType=UIReturnKeyDone;
        textView.delegate=self;
        [self addSubview:textView];
        
        //seperateLine
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+_margin, frame.size.width, 1)];
        lineView.backgroundColor=[UIColor grayColor];
        [self addSubview:lineView];
        
        //取消按钮
        UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame=CGRectMake(0, CGRectGetMaxY(lineView.frame), frame.size.width/2, CGRectGetHeight(titleLabel.frame)*2);
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
        self.cancelBtn=cancelBtn;
        [cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        //按钮分隔线
        UIView *seperateLine=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMinY(cancelBtn.frame), 1, CGRectGetHeight(cancelBtn.frame))];
        seperateLine.backgroundColor=[UIColor grayColor];
        [self addSubview:seperateLine];
    
        //确定按钮
        UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame=CGRectMake(CGRectGetMaxX(seperateLine.frame), CGRectGetMinY(cancelBtn.frame), CGRectGetWidth(cancelBtn.frame), CGRectGetHeight(cancelBtn.frame));
        self.submitBtn=sureBtn;
        [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(clickSubmit:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
        
    }
    return self;
}



-(void)textViewDidBeginEditing:(UITextView *)textView{
    textView.textColor=[UIColor blackColor];
    textView.text=nil;
}
/**
 * 通过代理方法去设置不能超过128个字，但是可编辑
 */
#pragma mark -UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if(textView.text.length>=128){
       textView.text=[textView.text substringToIndex:127];
    }
}


#pragma mark -return键弹回键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    return YES;    
    
}


#pragma mark -处理确定点击事件

-(void)clickSubmit:(id)sender{
    if(self.textView.editable){
        [self.textView resignFirstResponder];
    }
    if(self.textView.text.length>0){
        if([self.textView.textColor isEqual:[UIColor redColor]]||[self.textView.textColor isEqual:[UIColor whiteColor]]){
            [self.textView becomeFirstResponder];
        }else{
            if(self.submitBlock){
                self.submitBlock(self.textView.text);
            }
        }
    }else{
        self.textView.textColor=[UIColor redColor];
        self.textView.text=@"您输入的内容不能为空，请您输入内容";
    }
}

#pragma mark -处理取消点击事件

-(void)clickCancel:(id)sender{
    if(self.closeBlock){
        self.closeBlock();
    }
}


@end
