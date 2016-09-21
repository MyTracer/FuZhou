//
//  MessageTableViewCell.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/14.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbPosition;// 区段
@property (weak, nonatomic) IBOutlet UILabel *lbTime;// 消息


+ (id)initMessageCellwithPosition:(NSString *)position withProgress:(NSString *)message;
+ (id)initMessageCell;
@end
