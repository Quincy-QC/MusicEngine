//
//  MyCurrentSongTableViewCell.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyCurrentSongTableViewCell.h"
#import "DownloadListViewController.h"

@interface MyCurrentSongTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UIButton *downLoadButton;
@property (nonatomic, strong) SongModel *songModel;

@end

@implementation MyCurrentSongTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfiguredByModel:(SongModel *)model withIndex:(NSInteger)index {
    self.titleL.text = [NSString stringWithFormat:@"%ld %@-%@", index + 1, model.SN, model.NN];
    self.songModel = model;
}

- (IBAction)downLoadAction:(UIButton *)sender {
    DownloadListViewController *vc = [DownloadListViewController sharedDownloadListWithSongModel:nil];
    vc.isDownloading = ^() {
        [self createAlertControllerWithMessage:@"已经处于下载队列"];
    };
    vc.joinDownloadQueue = ^() {
        [self createAlertControllerWithMessage:@"加入下载队列"];
    };
    
    // modelArray里面存在两种model 直接重新请求数据获取播放歌曲时需要的model 进行下载
    [RequestManager requestWithUrlString:[NSString stringWithFormat:DANQU_DETAIL, self.songModel.SK, self.songModel.ID] requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        SongModel *model = [SongModel modelConfiguredByJson:dic];
        [DownloadListViewController sharedDownloadListWithSongModel:model];
    } error:^(NSError *error) {
        NSLog(@"error ========= %@", error);
    }];
}

- (void)createAlertControllerWithMessage:(NSString *)message {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self.myTableView.MyParentVC presentViewController:alertC animated:YES completion:^{
        [self performSelector:@selector(dismissAlertC) withObject:self afterDelay:0.5];
    }];
}

- (void)dismissAlertC {
    [self.myTableView.MyParentVC dismissViewControllerAnimated:YES completion:nil];
}

@end
