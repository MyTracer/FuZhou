//
//  WorkDataModel.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/29.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "WorkDataModel.h"

@implementation WorkDataModel
// 数据模型方法的实现
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
//        [self setValuesForKeysWithDictionary:dict];
        self.temp_bdid = dict[@"temp_bdid"];
        self.temp_pid = dict[@"temp_pid"];
        self.temp_pname = dict[@"temp_pname"];
        self.temp_pname1 = dict[@"temp_pname1"];
        self.temp_pname2 = dict[@"temp_pname2"];
        self.temp_pname3 = dict[@"temp_pname3"];
        self.sg_unit = dict[@"sg_unit"];
        self.riqi = dict[@"riqi"];
        self.sg_sjsw = dict[@"sg_sjsw"];
        self.sg_sjcz = dict[@"sg_sjcz"];
        self.dw_dwccz = dict[@"dw_dwccz"];
        self.kl_wcsw = dict[@"kl_wcsw"];
        self.ks_wccz = dict[@"ks_wccz"];
        self.baifenbi = dict[@"baifenbi"];
        self.infonote = dict[@"infonote"];
        self.remark = dict[@"remark"];
    }
    return self;
}
+ (instancetype)workDataWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

+ (NSArray *)workDatawithArray:(NSArray *)array
{
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self workDataWithDict:dict]];
    }
    return arrayM;
}

@end
