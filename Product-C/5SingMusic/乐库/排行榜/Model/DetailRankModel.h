//
//  DetailRankModel.h
//  Product-C
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailRankModel : NSObject

@property (nonatomic, strong) NSString *SN;
@property (nonatomic, strong) NSString *NN;
@property (nonatomic, strong) NSDictionary *user;
@property (nonatomic, strong) NSString *SK;
@property (nonatomic, strong) NSString *ID;

+ (NSMutableArray *)configureWithJsonDic:(NSDictionary *)jsonDic;

@end
