//
//  SelectViewController.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/30.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SelectViewController : UIViewController
// block传值
typedef void(^returnTextBlock)(NSString *idtext,NSString *datetext);
@property (nonatomic, copy) returnTextBlock returnTextBlock;
- (void)returnText:(returnTextBlock)textBlock;

@end
