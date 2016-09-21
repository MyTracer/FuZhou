//
//  SearchCellTableViewCell.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/29.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "SearchCellTableViewCell.h"
#import <UIKit/UIKit.h>

#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"

@implementation SearchCellTableViewCell
+ (id)initSearchCellwithPosition:(NSString *)position withProgress:(NSString *)progress
{
    SearchCellTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:nil options:nil] lastObject];
    cell.lbPosition.text = position;
    cell.lbProgress.text = progress;
    return cell;
}

+ (id)initSearchCell
{
    SearchCellTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:nil options:nil] lastObject];
    
    return cell;
}

- (MDRadialProgressView *)progressViewWithFrame:(CGRect)frame
{
    MDRadialProgressView *view = [[MDRadialProgressView alloc] initWithFrame:frame];
    
    // Only required in this demo to align vertically the progress views.
    //view.center = CGPointMake(self.view.center.x + 80, view.center.y);
    
    return view;
}

- (void)addProgresswithTotal:(NSInteger) numtotal withComplete:(NSInteger) numcomplete
{
    CGRect frame = CGRectMake(8,8,60,60);
    MDRadialProgressView *radialView = [self progressViewWithFrame:frame];
    
    radialView.progressTotal = numtotal;
    radialView.progressCounter = numcomplete;
    // radialView.theme.completedColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    radialView.theme.incompletedColor = [UIColor whiteColor];
    radialView.theme.thickness = 10;
    radialView.theme.sliceDividerHidden = YES;
    //radialView.theme.centerColor = radialView.theme.completedColor;
    
    radialView.theme.completedColor = [UIColor blackColor];
    radialView.theme.centerColor = [UIColor colorWithRed:229/255.0 green:237/255.0 blue:209/255.0 alpha:1.0];
    
    self.viewProgress.backgroundColor = [UIColor whiteColor];
    
    [self.viewProgress addSubview:radialView];
    
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
