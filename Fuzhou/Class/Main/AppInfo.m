//
//  AppInfo.m
//  06_Grids
//
//  Created by 韩江鹏 on 16/2/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo
@synthesize image = _image;
- (UIImage *)image
{
    if (_image == nil) {
        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}
// 模型实例化，需要实现2各方法
- (instancetype) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        /*
         保证属性一致(名称)
         模型的属性可以不全存在在字典中
         */
    }
    return self;
}

+ (instancetype)appInfoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
+ (NSArray *)applist
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil]];
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        AppInfo *appInfo = [AppInfo appInfoWithDict:dict];
        [arrM addObject:appInfo];
    }
    return arrM;
}

@end
