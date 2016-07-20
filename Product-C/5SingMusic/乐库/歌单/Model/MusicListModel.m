//
//  MusicListModel.m
//  Product-C
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicListModel.h"

@implementation MusicListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (NSMutableArray *)scrollModelConfigureWithJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dataDic =[jsonDic objectForKey:@"data"];
    //NSLog(@"%@",dataDic);
    NSArray *arr =[dataDic objectForKey:@"songMenu"];
    for (NSDictionary *dic in arr) {
        MusicListModel *model =[[MusicListModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
        NSLog(@"%@",model.playcount);
    }
    return array;
}

@end
