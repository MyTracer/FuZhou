//
//  MessageDataModel.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/14.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageDataModel : NSObject

@property (nonatomic,copy) NSString *bdid; // 标段id
@property (nonatomic,copy) NSString *date; // 日期
@property (nonatomic,copy) NSString *infonote; // 详细信息

@property (nonatomic,copy) NSString *bdname; // 标段名


// 推荐实现的方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)messageDataWithDict:(NSDictionary *)dict;

+ (NSArray *)messageDatawithArray:(NSArray *)array;

@end
