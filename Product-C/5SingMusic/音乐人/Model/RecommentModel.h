//
//  RecommentModel.h
//  Product-C
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommentModel : NSObject
@property (nonatomic,strong)NSString *I;
//@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *M;
@property (nonatomic,strong)NSString *NN;
@property (nonatomic,strong)NSNumber *FCRQ;
@property (nonatomic,strong)NSNumber *YCRQ;
@property (nonatomic,strong)NSDictionary *Song;

+ (NSMutableArray *)modelConfigureJsonDic:(NSDictionary*)JsonDic;
@end
