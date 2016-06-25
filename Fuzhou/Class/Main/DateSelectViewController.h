//
//  DateSelectViewController.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateSelectViewController : UIViewController
// block传值
typedef void(^returnTextBlock)(NSString *modeltext,NSString *datetext);
@property (nonatomic, copy) returnTextBlock returnTextBlock;
- (void)returnText:(returnTextBlock)textBlock;
@end
