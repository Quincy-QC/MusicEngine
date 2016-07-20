//
//  MusicPlayerViewController.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyDetailBaseViewController.h"

@interface MusicPlayerViewController : MyDetailBaseViewController

@property (nonatomic, strong) NSString *songType;
@property (nonatomic, strong) NSString *songID;
@property (nonatomic, strong) NSMutableArray *songArray;

// 创建单例播放器
+ (MusicPlayerViewController *)sharedMusicPlayerWithSongType:(NSString *)type songID:(NSString *)songID;
// 自动下一首
- (void)playNextMusicAuto;
// 播放
- (void)createDataWithType:(NSString *)type;

@end
