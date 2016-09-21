//
//  DateTableViewController.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DateCellTableViewCell;
@class AFNetworking;
@class DateDataModel;
@class DateDetailTableViewController;
@class DateSelectViewController;

@interface DateTableViewController : UITableViewController
@property (nonatomic,strong) NSArray *dateData;
@end
