//
//  ModelOfSquare.h
//  SingMusic
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOfSquare : NSObject

@property (nonatomic,strong)NSNumber *category;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSNumber *createtime;
@property (nonatomic,strong)NSString *dtID;
@property (nonatomic,strong)NSDictionary *user;

+ (NSMutableArray *)modelConfigureWithJson:(NSDictionary *)json;

@end
