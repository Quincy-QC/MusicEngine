//
//  ModelOfTjItems.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOfTjItems : NSObject
@property (nonatomic,strong)NSString *ImgUrl;
@property (nonatomic,strong)NSString *Title;
@property (nonatomic,strong)NSString *Url;

+ (NSMutableArray *)modelConfiguredByJson:(NSDictionary *)dic;

@end
