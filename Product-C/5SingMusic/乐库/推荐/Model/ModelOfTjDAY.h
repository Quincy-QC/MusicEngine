//
//  ModelOfTjDAY.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOfTjDAY : NSObject
@property (nonatomic, strong) NSString *Picture;
@property (nonatomic, strong) NSString *RecommendName;
@property (nonatomic, strong) NSString *RecommendWords;
@property (nonatomic, strong) NSString *Type;
@property (nonatomic, strong) NSString *Id;

+ (NSMutableArray *)modelConfiguredByJson:(NSDictionary *)dic;

@end
