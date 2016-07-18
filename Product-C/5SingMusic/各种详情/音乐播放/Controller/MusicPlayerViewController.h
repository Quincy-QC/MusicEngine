//
//  MusicPlayerViewController.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyDetailBaseViewController.h"

@interface MusicPlayerViewController : MyDetailBaseViewController

// 创建单例播放器
+ (MusicPlayerViewController *)sharedMusicPlayerWithSongType:(NSString *)type songID:(NSString *)songID;

@end
