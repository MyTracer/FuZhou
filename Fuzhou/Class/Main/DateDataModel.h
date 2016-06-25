//
//  DateDataModel.h
//  Fuzhou
//
//  Created by 韩江鹏 on 16/6/24.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateDataModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *date;
//@property (nonatomic,strong) NSArray *subTable;

// 推荐实现的方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)dateDataWithDict:(NSDictionary *)dict;

+ (NSArray *)dateDatawithArray:(NSArray *)array;
@end
