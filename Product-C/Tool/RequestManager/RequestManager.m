//
//  RequestManager.m
//  18UILessonCocoapods
//
//  Created by UntilYou-QC on 16/6/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

+ (void)requestWithUrlString:(NSString *)urlString requestType:(RequestType)requestType parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error {
    RequestManager *manager = [[RequestManager alloc] init];
    [manager requestWithUrlString:urlString requestType:requestType parDic:parDic finish:finish error:error];
}

- (void)requestWithUrlString:(NSString *)urlString requestType:(RequestType)requestType parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error {
    // block赋值
    self.finish = finish;
    self.error = error;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (requestType == requestGET) {
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self finishRequestReturnMainThread:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.error(error);
        }];
    } else {
        [manager POST:urlString parameters:parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self finishRequestReturnMainThread:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.error(error);
        }];
    }
}

// 获取数据后回到主线程
- (void)finishRequestReturnMainThread:(NSData *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.finish(data);
    });
}

@end
