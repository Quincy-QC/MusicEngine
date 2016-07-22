//
//  DownloadListViewController.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/21.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyDetailBaseViewController.h"
#import "SongModel.h"

@interface DownloadListViewController : MyDetailBaseViewController

@property (nonatomic, copy) void (^isDownloading)();
@property (nonatomic, copy) void (^joinDownloadQueue)();

+ (DownloadListViewController *)sharedDownloadListWithSongModel:(SongModel *)model;

@end
