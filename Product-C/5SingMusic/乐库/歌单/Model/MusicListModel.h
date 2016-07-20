//
//  MusicListModel.h
//  Product-C
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicListModel : NSObject

@property (nonatomic,strong)NSString *listId;
@property (nonatomic,strong)NSString *listName;
@property (nonatomic,strong)NSNumber *playcount;
@property (nonatomic,strong)NSString *url;

+ (NSMutableArray *)scrollModelConfigureWithJsonDic:(NSDictionary *)jsonDic;

@end
