//
//  Data.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/29.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "Data.h"
#import "AFNetworking.h"

@implementation Data
- (void)getJSON
{
    NSURL *URL = [NSURL URLWithString:@"http://112.124.30.42:8686/api/user"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *arr = responseObject;
        
        for (NSDictionary *dic in arr) {
            NSLog(@"%@",dic[@"temp_bdname"]);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
   
    
    
   
}


@end
