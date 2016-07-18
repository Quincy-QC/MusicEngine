//
//  DetailMusicModel.m
//  Product-C
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "DetailMusicModel.h"

@implementation DetailMusicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)initWithDict:(NSDictionary *)dict{
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (id)initWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


+ (NSMutableArray *)scrollModelConfigureWithJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *arr = jsonDic[@"data"];
    for (NSDictionary *dic in arr) {
        DetailMusicModel *model = [[DetailMusicModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}

@end
