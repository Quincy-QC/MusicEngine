//
//  ModelOfTjADV.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOfTjADV : NSObject
@property (nonatomic, strong) NSString *BehaviorType;
@property (nonatomic, strong) NSString *ImgUrl;
@property (nonatomic, strong) NSString *LinkUrl;
@property (nonatomic, strong) NSString *Title;

+ (NSMutableArray *)modelConfiguredByJson:(NSDictionary *)dic;

@end
