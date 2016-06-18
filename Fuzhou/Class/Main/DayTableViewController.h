//
//  DayTableViewController.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/29.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchCellTableViewCell;
@class AFNetworking;
@class WorkDataModel;
@class DayDetailTableViewController;
@class SelectViewController;
@class UserInfo;


@interface DayTableViewController : UITableViewController
@property (nonatomic,strong) NSArray *workData;
@end
