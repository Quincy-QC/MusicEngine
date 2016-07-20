//
//  DetailMusicModel.h
//  Product-C
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailMusicModel : NSObject

@property (nonatomic,strong) NSString *C;//描述
@property (nonatomic,strong) NSString *L;//类型
@property (nonatomic,strong) NSString *ID;//
@property (nonatomic,strong) NSString *P;//图片
@property (nonatomic,strong) NSDictionary *user;
@property (nonatomic, strong) NSString *SN;
@property (nonatomic, strong) NSString *NN;
@property (nonatomic, strong) NSString *SK;




+ (NSMutableArray *)scrollModelConfigureWithJsonDic:(NSDictionary *)jsonDic;

+ (id)initWithDict:(NSDictionary *)dict;
@end
