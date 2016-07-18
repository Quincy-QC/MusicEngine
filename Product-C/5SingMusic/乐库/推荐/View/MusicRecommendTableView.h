//
//  MusicRecommendTableView.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicOfDayTableViewCell.h"
#import "ModelOfTjADV.h"

@interface MusicRecommendTableView : UITableView
@property (nonatomic, strong) NSMutableArray *modelArrayOfTjADV;
@property (nonatomic, strong) NSMutableArray *modelArrayOfTjDAY;
@property (nonatomic, strong) NSMutableArray *modelArrayOfTjGeDan;
@property (nonatomic, strong) NSMutableArray *modelArrayOfTjLive;
@property (nonatomic, strong) NSMutableArray *modelArrayOfTjItems;

// 推荐广告blcok跳转
@property (nonatomic, copy) void (^AdvPush)(NSInteger index);
// 每日推荐block跳转
@property (nonatomic, copy) void (^DayPush)(NSString *type, NSString *songID);
// 推荐歌单block跳转
@property (nonatomic, copy) void (^GeDanPush)(NSInteger index);
// 专题block跳转
@property (nonatomic, copy) void (^ItemsPush)(NSString *url, NSString *title);

@end
