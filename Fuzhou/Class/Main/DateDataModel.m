//
//  DateDataModel.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "DateDataModel.h"


@implementation DateDataModel
// 数据模型方法的实现
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        //        [self setValuesForKeysWithDictionary:dict];
        self.title = dict[@"title"];
        self.count = dict[@"count"];
        self.date = dict[@"date"];
//        self.subTable = [SubTable subDatawithArray:dict[@"subTable"]];
        
    }
    return self;
}
+ (instancetype)dateDataWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

+ (NSArray *)dateDatawithArray:(NSArray *)array
{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self dateDataWithDict:dict]];
    }
    return arrayM;
}
@end
