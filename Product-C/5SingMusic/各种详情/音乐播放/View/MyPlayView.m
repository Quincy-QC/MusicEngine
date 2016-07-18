//
//  MyPlayView.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyPlayView.h"

@interface MyPlayView () <NCMusicEngineDelegate, AVAudioPlayerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *iconV;
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UISlider *musicProgressS;
@property (strong, nonatomic) IBOutlet UILabel *currentTimeL;
@property (strong, nonatomic) IBOutlet UILabel *totalTimeL;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic, strong) NCMusicEngine *player;

@end

@implementation MyPlayView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (NCMusicEngine *)player {
    if (!_player) {
        _player = [[NCMusicEngine alloc] init];
        _player.delegate = self;
//        _player.player.delegate = self;
    }
    return _player;
}

//- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
//    [(MusicPlayerViewController *)self.MyParentVC playNextMusicAuto];
//}

- (void)toPlayWithSong:(SongModel *)model {
    [self.iconV sd_setImageWithURL:[NSURL URLWithString:model.I]];
    self.titleL.text = model.SN;
    [self.player playUrl:[NSURL URLWithString:model.FN]];
    self.playButton.selected = YES;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)changeProgress {
    CGFloat totalTime = self.player.player.duration;
    CGFloat currentTime = self.player.player.currentTime;
    self.musicProgressS.value = currentTime/totalTime;
    self.currentTimeL.text = [NSString stringWithFormat:@"%02ld:%02ld", (NSInteger)currentTime/60, (NSInteger)currentTime%60];
    self.totalTimeL.text = [NSString stringWithFormat:@"%02ld:%02ld", (NSInteger)totalTime/60, (NSInteger)totalTime%60];
    if (currentTime >= totalTime - 1.0 && totalTime > 0) {
        [(MusicPlayerViewController *)self.MyParentVC playNextMusicAuto];
    }
}

- (IBAction)musicPlayAction:(UIButton *)sender {
    self.playButton.selected = !self.playButton.selected;
    if (self.playButton.selected) {
        [self.player resume];
    } else {
        [self.player stop];
    }
}
- (IBAction)moveMusicProgressAction:(UISlider *)sender {
    self.player.player.currentTime = sender.value * self.player.player.duration;
}
- (IBAction)shareAction:(UIButton *)sender {
}
- (IBAction)addListAction:(UIButton *)sender {
}

@end
