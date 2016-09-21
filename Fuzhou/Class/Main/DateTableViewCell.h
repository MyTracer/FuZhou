//
//  DateTableViewCell.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UILabel *lbcount;

+ (id)initDateCellwithPosition:(NSString *)title withProgress:(NSString *)count;
+ (id)initDateCell;

@end
