//
//  DownloadManager.h
//  QCDownloadManagerExample
//
//  Created by UntilYou-QC on 16/7/21.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Hash.h"
#import "SessionModel.h"

@interface DownloadManager : NSObject

#pragma mark ----- 单例 -----
+ (DownloadManager *)sharedInstance;

/** 开启下载任务 */
- (void)download:(NSString *)url progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlcok state:(void(^)(DownloadState state))stateBlock;
/** 下载进度 */
- (CGFloat)progress:(NSString *)url;
/** 资源总大小 */
- (NSInteger)fileTotalLength:(NSString *)url;
/** 是否完成下载 */
- (BOOL)isCompletion:(NSString *)url;
/** 删除资源 */
- (void)deleteFile:(NSString *)url;
/** 删除所有资源 */
- (void)deleteAllFile;


@end
