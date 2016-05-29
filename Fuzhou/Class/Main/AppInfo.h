//
//  AppInfo.h
//  06_Grids
//
//  Created by 韩江鹏 on 16/2/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppInfo : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic, strong, readonly) UIImage *image;
//
- (instancetype)initWithDict:(NSDictionary *)dict;
/** 类方法实例化对象 */
+ (instancetype)appInfoWithDict:(NSDictionary *)dict;
// 返回plist中所有数据的模型数组
+ (NSArray *)applist;
@end
