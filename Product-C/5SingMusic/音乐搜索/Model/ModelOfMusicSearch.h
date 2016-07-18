//
//  ModelOfMusicSearch.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOfMusicSearch : NSObject

@property (nonatomic, strong) NSString *songId;
@property (nonatomic, strong) NSString *songName;
@property (nonatomic, strong) NSString *type;

+ (NSMutableArray *)modelConfiguredByJson:(NSDictionary *)dic;

@end
