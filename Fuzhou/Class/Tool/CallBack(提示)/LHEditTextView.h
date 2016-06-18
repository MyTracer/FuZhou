//
//  LHEditTextView.h
//  LHPopTextView
//
//  Created by 刘旭辉 on 16/4/19.
//  Copyright © 2016年 刘旭辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHEditTextView : UIView

@property (nonatomic,weak)UIButton *grayBgView;
@property (nonatomic,copy)void (^requestDataBlock)(NSString *text);

+(instancetype)showWithController:(UIViewController *)controller;
+(void)showWithController:(UIViewController *)controller andRequestDataBlock:(void(^)(NSString *))requestDataBlock;
@end
