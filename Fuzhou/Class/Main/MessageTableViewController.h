//
//  MessageTableViewController.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/14.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageTableViewCell;
@class AFNetworking;
@class MessageDataModel;
@class MessageDetailTableViewController;
@class DayDetailTableViewController;
@class MessageSelectViewController;

@interface MessageTableViewController : UITableViewController
@property (nonatomic,strong) NSArray *messageData;
@end
