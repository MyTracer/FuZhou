//
//  MessageDetailTableViewController.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/15.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageDataModel;

@interface MessageDetailTableViewController : UITableViewController
@property (nonatomic,strong) MessageDataModel *detailData;
@end
