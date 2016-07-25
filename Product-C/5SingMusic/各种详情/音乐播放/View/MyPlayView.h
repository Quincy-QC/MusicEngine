//
//  MyPlayView.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyCommonView.h"
#import "SongModel.h"

@interface MyPlayView : MyCommonView
@property (strong, nonatomic) IBOutlet UIButton *musicAboveButton;
@property (strong, nonatomic) IBOutlet UIButton *musicNextButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic, strong) NCMusicEngine *player;

@property (nonatomic, copy) void (^MusicIsPlaying)(CGFloat totalProgress, CGFloat progress, UIImage *iconImage, NSString *title);

- (void)toPlayWithSong:(SongModel *)model;

@end
