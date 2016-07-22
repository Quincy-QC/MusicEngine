//
//  SessionModel.h
//  QCDownloadManagerExample
//
//  Created by UntilYou-QC on 16/7/21.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DownloadState) {
    DownloadStateSuspended,  // 下载暂停
    DownloadStateCompleted,  // 下载完成后
    DownloadStateStart,  // 下载中
    DownloadStateFailed      // 下载失败
};

@interface SessionModel : NSObject

/** 流 */
@property (nonatomic, strong) NSOutputStream *stream;

/** 下载地址 */
@property (nonatomic, strong) NSString *url;

/** 数据总长度 */
@property (nonatomic, assign) NSUInteger totalLength;

/** 下载进度 */
@property (nonatomic, copy) void (^progressBlock)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress);

/** 下载状态 */
@property (nonatomic, copy) void (^stateBlock)(DownloadState state);

@end
