//
//  SearchCellTableViewCell.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/29.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbPosition;// 区段
@property (weak, nonatomic) IBOutlet UILabel *lbProgress;// 完成量
@property (weak, nonatomic) IBOutlet UIView *viewProgress;// 进度条位置


+ (id)initSearchCellwithPosition:(NSString *)position withProgress:(NSString *)progress;
+ (id)initSearchCell;
- (void)addProgresswithTotal:(NSInteger) numtotal withComplete:(NSInteger) numcomplete;
@end
