//
//  ModelOfTjDAY.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "ModelOfTjDAY.h"

@implementation ModelOfTjDAY

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (NSMutableArray *)modelConfiguredByJson:(NSDictionary *)dic {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dic[@"data"]) {
        ModelOfTjDAY *model = [[ModelOfTjDAY alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        model.Id = dict[@"Content"][@"Id"];
        [array addObject:model];
    }
    return array;
}

@end
