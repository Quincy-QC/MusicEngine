//
//  MusicPlayerViewController.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyDetailBaseViewController.h"
@class MyPlayView;
@class SongModel;

@interface MusicPlayerViewController : MyDetailBaseViewController

@property (nonatomic, strong) NSString *songType;
@property (nonatomic, strong) NSString *songID;
@property (nonatomic, strong) NSMutableArray *songArray;
@property (nonatomic, assign) NSInteger myPlayIndex;
@property (nonatomic, strong) MyPlayView *myPlayV;
@property (nonatomic, strong) SongModel *songModel;

// 创建单例播放器
+ (MusicPlayerViewController *)sharedMusicPlayerWithSongType:(NSString *)type songID:(NSString *)songID;
// 自动下一首
- (void)playNextMusicAuto;
// 播放
- (void)createDataWithType:(NSString *)type;
// 上一首
- (void)aboveMusicAction;
// 下一首
- (void)nextMusicAction;

@end
