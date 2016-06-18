//
//  MessageSelectViewController.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/16.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageSelectViewController : UIViewController
// block传值
typedef void(^returnTextBlock)(NSString *startDate,NSString *endDate);
@property (nonatomic, copy) returnTextBlock returnTextBlock;
- (void)returnText:(returnTextBlock)textBlock;

@end
