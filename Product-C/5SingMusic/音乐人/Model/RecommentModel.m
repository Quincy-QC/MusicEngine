//
//  RecommentModel.m
//  Product-C
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "RecommentModel.h"

@implementation RecommentModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


+ (NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)JsonDic {
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *dataArray = JsonDic[@"data"];
    for (NSDictionary *dic in dataArray) {
        RecommentModel *model = [[RecommentModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}



@end
