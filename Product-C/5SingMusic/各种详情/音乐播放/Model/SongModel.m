//
//  SongModel.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "SongModel.h"

@implementation SongModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (SongModel *)modelConfiguredByJson:(NSDictionary *)dic {
    SongModel *model = [[SongModel alloc] init];
    [model setValuesForKeysWithDictionary:dic[@"data"]];
    model.NN = [dic valueForKeyPath:@"data.user.NN"];
    model.I = [dic valueForKeyPath:@"data.user.I"];
    return model;
}

@end
