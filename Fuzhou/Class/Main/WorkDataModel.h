//
//  WorkDataModel.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/29.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkDataModel : NSObject
@property(nonatomic,copy) NSString *temp_bdid; // 标段id
@property(nonatomic,copy) NSString *temp_pid; // 施工id
@property(nonatomic,copy) NSString *temp_pname; // 施工名
@property(nonatomic,copy) NSString *temp_pname1; // 施工名1
@property(nonatomic,copy) NSString *temp_pname2; // 施工名2
@property(nonatomic,copy) NSString *temp_pname3; // 施工名3
@property(nonatomic,copy) NSString *sg_unit; // 实物单位
@property(nonatomic,copy) NSString *riqi; // 日期
@property(nonatomic,copy) NSString *sg_sjsw; // 设计实物
@property(nonatomic,copy) NSString *sg_sjcz; // 设计产值
@property(nonatomic,copy) NSString *dw_dwcsw; // 当日完成实物
@property(nonatomic,copy) NSString *dw_dwccz; // 当日完成产值
@property(nonatomic,copy) NSString *kl_wcsw; // 开累完成实物
@property(nonatomic,copy) NSString *ks_wccz; // 开累完成产值
@property(nonatomic,copy) NSString *baifenbi; // 完成百分比
@property (nonatomic,copy) NSString *temp_bdname;

@property (nonatomic,copy) NSString *infonote; // 情况说明
@property (nonatomic,copy) NSString *remark; // 备注

// 推荐实现的方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)workDataWithDict:(NSDictionary *)dict;

+ (NSArray *)workDatawithArray:(NSArray *)array;
@end
