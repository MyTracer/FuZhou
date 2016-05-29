//
//  AppView.m
//  06_Grids
//
//  Created by 韩江鹏 on 16/2/25.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "AppView.h"
#import "AppInfo.h"
@interface AppView()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation AppView

+ (instancetype)appView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"AppView" owner:nil options:nil]lastObject];
}
+ (instancetype)appViewWithappInfo:(AppInfo *)appInfo
{
    AppView *view = [self appView];
    view.appInfo = appInfo;
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/**
 利用set方法设置界面显示
 */
- (void)setAppInfo:(AppInfo *)appInfo
{
    _appInfo = appInfo;
    self.label.text =appInfo.name;
    self.icon.image = appInfo.image;
}
- (IBAction)click:(UIButton *)button
{
    // 禁用按钮
    button.enabled = NO;
    /*
     改进：代理
     按钮点击后通知视图控制器
     */
    // 先判断对象是否实现了方法
    if ([self.delegate respondsToSelector:@selector(appViewDidClickDownloadButton:)]) {
        [self.delegate appViewDidClickDownloadButton:self];//通知代理
    }
    
    
    
    
    
}

@end
