//
//  DownloadManager.m
//  QCDownloadManagerExample
//
//  Created by UntilYou-QC on 16/7/21.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

// 缓存主目录
#define QCCachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"QCCaches"]
// 保存文件名
#define QCFileName(url) url.md5String
// 文件存放路径
#define QCFileFullPath(url) [QCCachesDirectory stringByAppendingPathComponent:QCFileName(url)]
// 文件已下载长度
#define QCDownloadLength(url) [[[NSFileManager defaultManager] attributesOfItemAtPath:QCFileFullPath(url) error:nil][NSFileSize] integerValue]
// 存储文件总长度的文件路径
#define QCTotalLengthFullPath [QCCachesDirectory stringByAppendingPathComponent:@"totalLength.plist"]

#import "DownloadManager.h"

@interface DownloadManager () <NSURLSessionDataDelegate>
@property (nonatomic, strong) NSMutableDictionary *tasks; // 存储所有下载任务
@property (nonatomic, strong) NSMutableDictionary *sessionModels; // 存储sessionModel

@end

@implementation DownloadManager

- (NSMutableDictionary *)tasks {
    if (!_tasks) {
        _tasks = [NSMutableDictionary dictionary];
    }
    return _tasks;
}

- (NSMutableDictionary *)sessionModels {
    if (!_sessionModels) {
        _sessionModels = [NSMutableDictionary dictionary];
    }
    return _sessionModels;
}

+ (DownloadManager *)sharedInstance {
    static DownloadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DownloadManager alloc] init];
    });
    return manager;
}

/**
 *  创建缓存目录文件
 */
- (void)createCachesDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:QCCachesDirectory]) {
        [fileManager createDirectoryAtPath:QCCachesDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

/** 开启下载任务 */
- (void)download:(NSString *)url progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlcok state:(void(^)(DownloadState state))stateBlock {
    
    if (!url) return;
    if ([self isCompletion:url]) {
        stateBlock(DownloadStateCompleted);
        return;
    }
    
    // 暂停
    if ([self.tasks valueForKey:QCFileName(url)]) {
        [self handle:url];
        return;
    }
    
    // 创建缓存目录
    [self createCachesDirectory];
    
    // 创建session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    // 创建流
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:QCFileFullPath(url) append:YES];
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 设置请求头
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-", QCDownloadLength(url)];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    // 创建data任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    NSUInteger taskIdentifier = arc4random() % (arc4random() % 10000 + arc4random() % 10000);
    [task setValue:@(taskIdentifier) forKeyPath:@"taskIdentifier"];
    
    // 保存任务
    [self.tasks setValue:task forKey:QCFileName(url)];
    
    SessionModel *sessionModel = [[SessionModel alloc] init];
    sessionModel.url = url;
    sessionModel.progressBlock = progressBlcok;
    sessionModel.stateBlock = stateBlock;
    sessionModel.stream = stream;
    [self.sessionModels setValue:sessionModel forKey:@(task.taskIdentifier).stringValue];
    
    [self start:url];
}

/**
 *  开始下载
 */
- (void)start:(NSString *)url {
    NSURLSessionDataTask *task = [self getTask:url];
    [task resume];
    
    [self getSession:task.taskIdentifier].stateBlock(DownloadStateStart);
}

/**
 *  暂停
 */
- (void)pause:(NSString *)url {
    NSURLSessionDataTask *task = [self getTask:url];
    [task suspend];
    
    [self getSession:task.taskIdentifier].stateBlock(DownloadStateSuspended);
}


- (void)handle:(NSString *)url {
    NSURLSessionDataTask *task = [self getTask:url];
    if (task.state == NSURLSessionTaskStateRunning) {
        [self pause:url];
    } else  {
        [self start:url];
    }
}

/**
 *  根据url获取相应的下载任务
 */
- (NSURLSessionDataTask *)getTask:(NSString *)url {
    return [self.tasks valueForKey:QCFileName(url)];
}

/**
 *  根据url获取对应的下载信息model
 */
- (SessionModel *)getSession:(NSUInteger)taskIdentifier {
    return [self.sessionModels valueForKey:@(taskIdentifier).stringValue];
}

/** 下载进度 */
- (CGFloat)progress:(NSString *)url {
    return [self fileTotalLength:url] == 0 ? 0.0 : 1.0 * QCDownloadLength(url) / [self fileTotalLength:url];
}

/** 资源总大小 */
- (NSInteger)fileTotalLength:(NSString *)url {
    return [[NSDictionary dictionaryWithContentsOfFile:QCTotalLengthFullPath][QCFileName(url)] integerValue];
}

/** 是否完成下载 */
- (BOOL)isCompletion:(NSString *)url {
    if ([self fileTotalLength:url] && QCDownloadLength(url) == [self fileTotalLength:url]) {
        return YES;
    }
    return NO;
}

/** 删除资源 */
- (void)deleteFile:(NSString *)url {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:QCFileFullPath(url)]) {
        // 删除沙盒中的资源
        [fileManager removeItemAtPath:QCFileFullPath(url) error:nil];
        // 删除任务
        [self.tasks removeObjectForKey:QCFileName(url)];
        [self.sessionModels removeObjectForKey:@([self getTask:url].taskIdentifier).stringValue];
        // 删除plist中的资源总长度
        if ([fileManager fileExistsAtPath:QCTotalLengthFullPath]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:QCTotalLengthFullPath];
            [dict removeObjectForKey:QCFileName(url)];
            [dict writeToFile:QCTotalLengthFullPath atomically:YES];
        }
    }
}

/** 删除所有资源 */
- (void)deleteAllFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:QCCachesDirectory]) {
        // 删除沙盒中所有资源的文件夹
        [fileManager removeItemAtPath:QCCachesDirectory error:nil];
        // 删除任务
        [[self.tasks allValues] makeObjectsPerformSelector:@selector(cancel)];
        [self.tasks removeAllObjects];
        
        for (SessionModel *model in [self.sessionModels allValues]) {
            [model.stream close];
        }
        [self.sessionModels removeAllObjects];
        // 删除资源总长度
        if ([fileManager fileExistsAtPath:QCTotalLengthFullPath]) {
            [fileManager removeItemAtPath:QCTotalLengthFullPath error:nil];
        }
    }
}

#pragma mark ----- NSURLSessionDataDelegate -----
/**
 *  接收到相应
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    SessionModel *sessionModel = [self getSession:dataTask.taskIdentifier];
    
    // 打开流
    [sessionModel.stream open];
    
    // 获得服务器这次请求 返回数据总长度
    NSInteger totalLength = [response.allHeaderFields[@"Content-Length"] integerValue] + QCDownloadLength(sessionModel.url);
    sessionModel.totalLength = totalLength;
    
    // 存储总长度
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:QCTotalLengthFullPath];
    if (dict == nil) dict = [NSMutableDictionary dictionary];
    dict[QCFileName(sessionModel.url)] = @(totalLength);
    [dict writeToFile:QCTotalLengthFullPath atomically:YES];
    
    // 允许接收服务器的数据
    completionHandler(NSURLSessionResponseAllow);
}

/**
 *  接收到服务器返回的数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    SessionModel *sessionModel = [self getSession:dataTask.taskIdentifier];
    
    // 写入数据
    [sessionModel.stream write:data.bytes maxLength:data.length];
    
    // 下载进度
    NSUInteger receivedSize = QCDownloadLength(sessionModel.url);
    NSUInteger expectedSize = sessionModel.totalLength;
    CGFloat progress = 1.0 * receivedSize / expectedSize;
    
    sessionModel.progressBlock(receivedSize, expectedSize, progress);
}

/**
 *  请求完毕
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    SessionModel *sessionModel = [self getSession:task.taskIdentifier];
    if (!sessionModel) return;
    
    if ([self isCompletion:sessionModel.url]) {
        // 下载完成
        sessionModel.stateBlock(DownloadStateCompleted);
    } else if (error) {
        // 下载失败
        sessionModel.stateBlock(DownloadStateFailed);
    }
    
    // 关闭流
    [sessionModel.stream close];
    sessionModel.stream = nil;
    
    // 清除任务
    [self.tasks removeObjectForKey:QCFileName(sessionModel.url)];
    [self.sessionModels removeObjectForKey:@(task.taskIdentifier).stringValue];
}

@end
