//
//  ChangeDataMusician.m
//  Product-C
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "ChangeDataMusician.h"
static ChangeDataMusician *manager = nil;
@implementation ChangeDataMusician

+ (ChangeDataMusician *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ChangeDataMusician alloc] init];
    });
    return manager;
}



@end
