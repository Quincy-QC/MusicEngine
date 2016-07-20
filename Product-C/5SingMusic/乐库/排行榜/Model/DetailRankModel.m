//
//  DetailRankModel.m
//  Product-C
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "DetailRankModel.h"

@implementation DetailRankModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (NSMutableArray *)configureWithJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dic = jsonDic[@"data"];
    NSArray *arr = dic[@"songs"];
    for (NSDictionary *dic in arr) {
        DetailRankModel *model = [[DetailRankModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}

@end
