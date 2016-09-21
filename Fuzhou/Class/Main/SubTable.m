//
//  SubTable.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "SubTable.h"

@implementation SubTable
// 数据模型方法的实现
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        //        [self setValuesForKeysWithDictionary:dict];
        self.bdname = dict[@"bdname"];
        self.bdid = dict[@"bdid"];
        self.date = dict[@"date"];
        self.infonote = dict[@"infonote"];
        self.remark = dict[@"remark"];
    }
    return self;
}
+ (instancetype)subDataWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

+ (NSArray *)subDatawithArray:(NSArray *)array
{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self subDataWithDict:dict]];
    }
    return arrayM;
}
@end
