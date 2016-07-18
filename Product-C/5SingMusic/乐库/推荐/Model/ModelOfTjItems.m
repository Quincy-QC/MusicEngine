//
//  ModelOfTjItems.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "ModelOfTjItems.h"

@implementation ModelOfTjItems

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (NSMutableArray *)modelConfiguredByJson:(NSDictionary *)dic {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dic[@"data"]) {
        ModelOfTjItems *model = [[ModelOfTjItems alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [array addObject:model];
    }
    return array;
}

@end
