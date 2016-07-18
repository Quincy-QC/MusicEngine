//
//  ModelOfTjGeDan.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOfTjGeDan : NSObject
@property (nonatomic, strong) NSString *Picture;
@property (nonatomic, strong) NSString *Title;
@property (nonatomic, strong) NSString *PlayCount;
@property (nonatomic, strong) NSString *SongListId;

+ (NSMutableArray *)modelConfiguredByJson:(NSDictionary *)dic;

@end
