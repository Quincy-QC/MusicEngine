//
//  ModelOfTjLive.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "ModelOfTjLive.h"

@implementation ModelOfTjLive

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (NSMutableArray *)modelConfiguredByJson:(NSArray *)arr {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        ModelOfTjLive *model = [[ModelOfTjLive alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [array addObject:model];
    }
    return array;
}

@end
