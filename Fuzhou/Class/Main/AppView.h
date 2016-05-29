//
//  AppView.h
//  06_Grids
//
//  Created by 韩江鹏 on 16/2/25.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppInfo,AppView;
@protocol AppViewDelegate <NSObject>
@required
// 协议名，协议方法
- (void)appViewDidClickDownloadButton:(AppView *)appView;

@end


@interface AppView : UIView
// 定义协议属性
@property (nonatomic,weak) id<AppViewDelegate>delegate;

@property (nonatomic,strong)AppInfo *appInfo;
// 自定义视图中数据来源都是数据模型
// 使用模型自定义视图显示
/** 类方法方便调用视图 */
+ (instancetype)appView;
/** 实例化视图，并使用appInfo设置视图显示 */
+ (instancetype)appViewWithappInfo:(AppInfo *)appInfo;
@end
