//
//  SubTable.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubTable : NSObject
@property (nonatomic,copy) NSString *bdname;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *bdid;
@property (nonatomic,copy) NSString *infonote;
@property (nonatomic,copy) NSString *remark;

// 推荐实现的方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)subDataWithDict:(NSDictionary *)dict;

+ (NSArray *)subDatawithArray:(NSArray *)array;

@end
