//
//  Data.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/29.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "Data.h"
#import "AFNetworking.h"
#import "cbsNetWork.h"

@implementation Data
- (void)getJSON
{
    
    
    [[cbsNetWork sharedManager] requestWithMethod:GET WithPath:@"get" WithParams:nil WithSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        NSLog(@"block");
    } WithFailurBlock:^(NSError *error) {
        
    }];
    
    
    
    
   
}


@end
