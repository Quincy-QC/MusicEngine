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

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.SN forKey:@"SN"];
    [aCoder encodeObject:self.NN forKey:@"NN"];
    [aCoder encodeObject:self.I forKey:@"I"];
    [aCoder encodeObject:self.FN forKey:@"FN"];
    [aCoder encodeObject:self.SW forKey:@"SW"];
    [aCoder encodeObject:self.M forKey:@"M"];
    [aCoder encodeObject:self.SK forKey:@"SK"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.SN = [aDecoder decodeObjectForKey:@"SN"];
        self.NN = [aDecoder decodeObjectForKey:@"NN"];
        self.I = [aDecoder decodeObjectForKey:@"I"];
        self.FN = [aDecoder decodeObjectForKey:@"FN"];
        self.SW = [aDecoder decodeObjectForKey:@"SW"];
        self.M = [aDecoder decodeObjectForKey:@"M"];
        self.SK = [aDecoder decodeObjectForKey:@"SK"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
    }
    return self;
}

@end
