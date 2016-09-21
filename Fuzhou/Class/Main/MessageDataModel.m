//
//  MessageDataModel.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/14.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "MessageDataModel.h"

@implementation MessageDataModel

// 数据模型方法的实现
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
//        [self setValuesForKeysWithDictionary:dict];
        self.bdid = dict[@"bdid"];
        self.date = dict[@"ds_date"];
        self.infonote = dict[@"content"];
        
        self.bdname = dict[@"bdname"];
    }
    return self;
}
+ (instancetype)messageDataWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

+ (NSArray *)messageDatawithArray:(NSArray *)array
{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self messageDataWithDict:dict]];
    }
    return arrayM;
}

@end
