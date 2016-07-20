//
//  MusicRankListModel.h
//  Product-C
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicRankListModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSArray *songs;

+ (NSMutableArray *)configureWithjsonDic:(NSDictionary *)jsonDic;

@end
