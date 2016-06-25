//
//  DateTableViewCell.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "DateTableViewCell.h"

@implementation DateTableViewCell

+ (id)initDateCell{
    DateTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DateCell" owner:nil options:nil] lastObject];
    
    return cell;
}
+ (id)initDateCellwithPosition:(NSString *)title withProgress:(NSString *)count
{
    DateTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DateCell" owner:nil options:nil] lastObject];
    cell.lbtitle.text = title;
    cell.lbcount.text = count;
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
