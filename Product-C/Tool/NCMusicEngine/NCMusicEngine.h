//
//  NCMusicEngine.h
//  NCMusicEngine
//
//  Created by nickcheng on 12-12-2.
//  Copyright (c) 2012年 NC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFDownloadRequestOperation.h"
#import <AVFoundation/AVFoundation.h>

#define kNCMusicEngineCacheFolderName @"com.TQ.NCMusicEngine"
#define kNCMusicEngineCheckMusicInterval 0.1f // Seconds
#define kNCMusicEngineSizeBuffer 100000.0f // Bytes
#define kNCMusicEnginePauseMargin 1.0f  // Seconds
#define kNCMusicEnginePlayMargin 5.0f // Seconds

@protocol NCMusicEngineDelegate;


typedef enum {
  NCMusicEnginePlayStateStopped,
  NCMusicEnginePlayStatePlaying,
  NCMusicEnginePlayStatePaused,
  NCMusicEnginePlayStateEnded,
  NCMusicEnginePlayStateError
} NCMusicEnginePlayState;

typedef enum {
  NCMusicEngineDownloadStateNotDownloaded,
  NCMusicEngineDownloadStateDownloading,
//  NCMusicEngineDownloadStatePartial,
  NCMusicEngineDownloadStateDownloaded,
  NCMusicEngineDownloadStateError
} NCMusicEngineDownloadState;


@interface NCMusicEngine : NSObject

@property (nonatomic, assign, readonly) NCMusicEnginePlayState playState;
@property (nonatomic, assign, readonly) NCMusicEngineDownloadState downloadState;
@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (weak) id<NCMusicEngineDelegate> delegate;

- (id)initWithSetBackgroundPlaying:(BOOL)setBGPlay;
- (void)playUrl:(NSURL*)url;
- (void)playUrl:(NSURL *)url withCacheKey:(NSString *)cacheKey;
- (void)pause;
- (void)resume;
- (void)stop; // Stop music and stop download.

@end


@protocol NCMusicEngineDelegate <NSObject>

//- (NSURL*)engineExpectsNextUrl:(NCMusicEngine *)engine;

@optional
- (void)engine:(NCMusicEngine *)engine didChangePlayState:(NCMusicEnginePlayState)playState;
- (void)engine:(NCMusicEngine *)engine didChangeDownloadState:(NCMusicEngineDownloadState)downloadState;
- (void)engine:(NCMusicEngine *)engine downloadProgress:(CGFloat)progress;
- (void)engine:(NCMusicEngine *)engine playProgress:(CGFloat)progress;

@end
