//
//  SongModel.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongModel : NSObject
@property (nonatomic, strong) NSString *SN; // title
@property (nonatomic, strong) NSString *NN; // uname
@property (nonatomic, strong) NSString *I; // icon
@property (nonatomic, strong) NSString *FN; // music
@property (nonatomic, strong) NSString *SW; // lyric
@property (nonatomic, strong) NSString *M; // inspiration

+ (SongModel *)modelConfiguredByJson:(NSDictionary *)dic;

@end
