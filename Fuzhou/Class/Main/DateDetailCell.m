//
//  DateDetailCell.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "DateDetailCell.h"

@implementation DateDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (id)initDateDetailCell{
    DateDetailCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DateDetailCell" owner:nil options:nil] lastObject];
    
    return cell;
}
+ (id)initDateDetailCellwithPosition:(NSString *)name
{
    DateDetailCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DateDetailCell" owner:nil options:nil] lastObject];
    cell.lbname.text = name;
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
