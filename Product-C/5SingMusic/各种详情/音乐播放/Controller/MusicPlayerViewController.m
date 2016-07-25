//
//  MusicPlayerViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "MyCurrentSongView.h"
#import "MyLyricView.h"
#import "MyInspirationView.h"
#import "MyPlayView.h"
#import "SongModel.h"

@interface MusicPlayerViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) MyCurrentSongView *myCurrentSongV;
@property (nonatomic, strong) MyLyricView *myLyricV;
@property (nonatomic, strong) MyInspirationView *myInspirationV;

@end

@implementation MusicPlayerViewController
+ (MusicPlayerViewController *)sharedMusicPlayerWithSongType:(NSString *)type songID:(NSString *)songID {
    static MusicPlayerViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[MusicPlayerViewController alloc] init];
    });
    vc.songType = type;
    vc.songID = songID;
    if (vc.songType && vc.songID) {
        if ([NSString stringWithFormat:@"%@", vc.songModel.ID] == vc.songID) {
            return vc;
        }
        for (SongModel *model in vc.songArray) {
            if (model.ID == vc.songID) {
                [vc createDataWithType:@"1"];
                return vc;
            }
        }
        [vc createDataWithType:@"2"];
    }
    return vc;
}

- (instancetype)init {
    self.hidesBottomBarWhenPushed = YES;
    return [super init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addObserver:self forKeyPath:@"songModel" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"songModel"]) {
        NSValue *newValue = change[NSKeyValueChangeNewKey];
        NSValue *oldValue = change[NSKeyValueChangeOldKey];
        if (![newValue isEqual:oldValue]) {
            for (NSInteger i = 0; i < self.songArray.count; i++) {
                SongModel *model = self.songArray[i];
                if ([[NSString stringWithFormat:@"%@", model.ID] isEqualToString:[NSString stringWithFormat:@"%@", self.songModel.ID]]) {
                    self.myPlayIndex = i;
                    [self.myCurrentSongV.songTableView reloadData];
                    return;
                }
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeObserver:self forKeyPath:@"songModel"];
}

- (void)createDataWithType:(NSString *)type {
    [SVProgressHUD show];
    [RequestManager requestWithUrlString:[NSString stringWithFormat:DANQU_DETAIL, self.songType, self.songID] requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.songModel = [SongModel modelConfiguredByJson:dic];
        if ([type isEqualToString:@"2"]) {
            [self.songArray insertObject:self.songModel atIndex:0];
        }
        [self refreshMyViews];
        [SVProgressHUD dismissWithDelay:0.3];
    } error:^(NSError *error) {
        [SVProgressHUD dismissWithDelay:0.3];
        NSLog(@"error ========= %@", error);
    }];
}

- (void)refreshMyViews {
    [self.myLyricV configureMyLyricViewWithString:self.songModel.SW];
    [self.myInspirationV configureMyInspirationViewWithString:self.songModel.M];
    [self.myCurrentSongV ConfigMyViewWithArray:self.songArray];
    [self.myPlayV toPlayWithSong:self.songModel];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.songModel.I]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self createNavigationView];
    [self createScrollView];
    [self.view addSubview:self.myPlayV];
}

// 创建scrollView
- (void)createScrollView {
    [self.view addSubview:self.imageV];
    [self.view addSubview:self.scrollV];
    [self.scrollV addSubview:self.myCurrentSongV];
    [self.scrollV addSubview:self.myLyricV];
    [self.scrollV addSubview:self.myInspirationV];
}

// 修改导航栏样式
- (void)createNavigationView {
    self.navView.backgroundColor = [UIColor colorWithRed:239 green:239 blue:239 alpha:0.1];
    [self.navView.rightButton removeFromSuperview];
    self.navView.titleLabel.text = @"歌词";
    self.navView.titleLabel.font = [UIFont systemFontOfSize:20];
    self.navView.titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *moreButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    moreButton.frame = self.navView.rightButton.frame;
    [moreButton setImage:[UIImage imageNamed:@"navMore"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"navMore"] forState:UIControlStateHighlighted];
    [moreButton addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:moreButton];
    [self.navView.leftButton setImage:[UIImage imageNamed:@"navLeft"] forState:UIControlStateNormal];
    [self.navView.leftButton setImage:[UIImage imageNamed:@"navLeft"] forState:UIControlStateHighlighted];
}

- (void)moreClick {
    NSLog(@"分享");
    [self shareAction];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat x = self.scrollV.contentOffset.x;
    if (x == 0) {
        self.navView.titleLabel.text = @"当前播放";
    } else if (x == KScreenW) {
        self.navView.titleLabel.text = @"歌词";
    } else if (x == KScreenW * 2) {
        self.navView.titleLabel.text = @"灵感";
    }
}

#pragma mark ----- 懒加载 -----
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH - 64 * 3)];
        _imageV.image = [UIImage imageNamed:@"song_banner"];
        _imageV.alpha = 0.1;
    }
    return _imageV;
}

- (UIScrollView *)scrollV {
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64 * 4)];
        _scrollV.contentSize = CGSizeMake(3 * KScreenW, KScreenH - 64 * 4);
        _scrollV.contentOffset = CGPointMake(KScreenW, 0);
        _scrollV.pagingEnabled = YES;
        _scrollV.delegate = self;
    }
    return _scrollV;
}

- (MyCurrentSongView *)myCurrentSongV {
    if (!_myCurrentSongV) {
        _myCurrentSongV = [[MyCurrentSongView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH - 64 * 4)];
        _myCurrentSongV.MyParentVC = self;
    }
    return _myCurrentSongV;
}

- (MyLyricView *)myLyricV {
    if (!_myLyricV) {
        _myLyricV = [[MyLyricView alloc] initWithFrame:CGRectMake(KScreenW, 0, KScreenW, KScreenH - 64 * 4)];
    }
    return _myLyricV;
}

- (MyInspirationView *)myInspirationV {
    if (!_myInspirationV) {
        _myInspirationV = [[MyInspirationView alloc] initWithFrame:CGRectMake(2 * KScreenW, 0, KScreenW, KScreenH - 64 * 4)];
    }
    return _myInspirationV;
}

- (MyPlayView *)myPlayV {
    if (!_myPlayV) {
        _myPlayV = [[[NSBundle mainBundle] loadNibNamed:@"MyPlayView" owner:self options:nil] firstObject];
        _myPlayV.frame = CGRectMake(0, KScreenH - 64 * 3, KScreenW, 64 * 3);
        _myPlayV.MyParentVC = self;
        [_myPlayV.musicAboveButton addTarget:self action:@selector(aboveMusicAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_myPlayV.musicNextButton addTarget:self action:@selector(nextMusicAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _myPlayV;
}

- (NSMutableArray *)songArray {
    if (!_songArray) {
        _songArray = [NSMutableArray array];
    }
    return _songArray;
}

#pragma mark ----- 切歌 -----
- (void)aboveMusicAction {
    self.myPlayIndex -= 1;
    if (self.myPlayIndex < 0) {
        self.myPlayIndex = self.songArray.count - 1;
    }
    SongModel *model = self.songArray[self.myPlayIndex];
    self.songType = model.SK;
    self.songID = model.ID;
    [self createDataWithType:@"1"];
}

- (void)nextMusicAction {
    self.myPlayIndex += 1;
    if (self.myPlayIndex >= self.songArray.count) {
        self.myPlayIndex = 0;
    }
    SongModel *model = self.songArray[self.myPlayIndex];
    self.songType = model.SK;
    self.songID = model.ID;
    [self createDataWithType:@"1"];
}

- (void)playNextMusicAuto {
    NSLog(@"自动切歌");
    [self nextMusicAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareAction {
    //1、创建分享参数
    NSArray* imageArray = @[self.songModel.I];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:self.songModel.M
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://5sing.kugou.com/index.html"]
                                          title:self.songModel.SN
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
