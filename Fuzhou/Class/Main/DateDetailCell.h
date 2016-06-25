//
//  DateDetailCell.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbname;
+ (id)initDateDetailCellwithPosition:(NSString *)name;
+ (id)initDateDetailCell;
@end
