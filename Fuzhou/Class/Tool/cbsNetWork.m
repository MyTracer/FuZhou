//
//  cbsNetWork.m
//  Fuzhou
//
//  Created by 韩江鹏 on 16/5/30.
//  Copyright © 2016年 韩江鹏. All rights reserved.
//

#import "cbsNetWork.h"


@implementation cbsNetWork
// 网络请求抽取。工具类

+ (instancetype)sharedManager {
    static cbsNetWork *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return manager;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
{
    NSString *url = @"http://112.124.30.42:8686/api/user";
    switch (method) {
        case GET:{
            [self GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:path parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
            }];
            break;
        }
        default:
            break;
    }    
}
@end
