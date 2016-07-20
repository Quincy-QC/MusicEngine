//
//  MusicRankListModel.m
//  Product-C
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicRankListModel.h"

@implementation MusicRankListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (NSMutableArray *)configureWithjsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *Arr = jsonDic[@"data"];
    for (NSDictionary *dic in Arr) {
        MusicRankListModel *model = [[MusicRankListModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}

@end
