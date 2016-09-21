//
//  LHTopTextView.h
//  LHPopTextView
//
//  Created by 刘旭辉 on 16/4/19.
//  Copyright © 2016年 刘旭辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHTopTextView : UIView

@property (nonatomic,weak)UITextView *textView;
@property (nonatomic,weak)UIButton *submitBtn;
@property (nonatomic,weak)UIButton *cancelBtn;

@property (nonatomic,weak)UILabel *titleLabel;

@property (nonatomic,copy) void(^submitBlock)(NSString * text);
@property (nonatomic,copy) void(^closeBlock)();

@end
