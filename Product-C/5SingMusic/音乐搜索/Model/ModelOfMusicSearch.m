//
//  ModelOfMusicSearch.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "ModelOfMusicSearch.h"

@implementation ModelOfMusicSearch

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (NSMutableArray *)modelConfiguredByJson:(NSDictionary *)dic {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dic[@"data"][@"songArray"]) {
        ModelOfMusicSearch *model = [[ModelOfMusicSearch alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [array addObject:model];
    }
    return array;
}

@end
