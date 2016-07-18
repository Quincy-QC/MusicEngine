//
//  ModelOfTjLive.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOfTjLive : NSObject
@property (nonatomic,strong) NSString *audience;
@property (nonatomic,strong) NSString *imgPath;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *roomId;
@property (nonatomic,strong) NSString *week;
@property (nonatomic,strong) NSString *time;

+ (NSMutableArray *)modelConfiguredByJson:(NSArray *)arr;

@end
