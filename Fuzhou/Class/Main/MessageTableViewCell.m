//
//  MessageTableViewCell.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/14.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell
+ (id)initMessageCell{
    MessageTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:nil options:nil] lastObject];
    
    return cell;
}
+ (id)initMessageCellwithPosition:(NSString *)position withProgress:(NSString *)message
{
    MessageTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:nil options:nil] lastObject];
    cell.lbPosition.text = position;
    cell.lbTime.text = message;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
