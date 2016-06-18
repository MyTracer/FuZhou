//
//  DayDetailTableViewController.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/10.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WorkDataModel;
@class AFNeting;
@class LHEditTextView;
@class UserInfo;

@interface DayDetailTableViewController : UITableViewController
@property (nonatomic,strong) WorkDataModel *detailData;
@end
