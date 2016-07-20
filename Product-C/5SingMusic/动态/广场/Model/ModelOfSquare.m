//
//  ModelOfSquare.m
//  SingMusic
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

#import "ModelOfSquare.h"

@implementation ModelOfSquare

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.dtID = value;
    }
}


+ (NSMutableArray *)modelConfigureWithJson:(NSDictionary *)json {
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in json[@"data"]) {
        ModelOfSquare *model = [[ModelOfSquare alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }    
    return arr;
}


@end
