//
//  DownloadListViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/21.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "DownloadListViewController.h"
#import "DownloadListTableViewCell.h"

@interface DownloadListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *songModelArray;
@property (nonatomic, strong) NSMutableDictionary *downloadStateDic;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DownloadListViewController
+ (DownloadListViewController *)sharedDownloadListWithSongModel:(SongModel *)model {
    static DownloadListViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[DownloadListViewController alloc] init];
    });
    [vc unarchiverModel:vc.songModelArray];
    if (model) {
        for (SongModel *tempModel in vc.songModelArray) {
            if ([tempModel.FN isEqualToString:model.FN]) {
                NSLog(@"处于下载队列");
                vc.isDownloading();
                return vc;
            }
        }
        // 归档
        [vc archiverModel:model];
        [vc.songModelArray insertObject:model atIndex:0];
        [vc.tableV insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        vc.joinDownloadQueue();
        
        // 刷新cell数据
        DownloadListTableViewCell *cell = [vc.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [[DownloadManager sharedInstance] download:model.FN progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.musicTitleL.text = model.SN;
                cell.musicProgressL.text = [NSString stringWithFormat:@"%.f%%", [[DownloadManager sharedInstance] progress:model.FN] *100];
                cell.musicProgressV.progress = [[DownloadManager sharedInstance] progress:model.FN];
            });
        } state:^(DownloadState state) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.musicDownloadButton setTitle:[vc getTitleWithDownloadState:state] forState:(UIControlStateNormal)];
                [vc.downloadStateDic setValue:@(state) forKey:model.FN];
            });
        }];
    }
    return vc;
}

// 反归档model
- (void)unarchiverModel:(NSMutableArray *)songModelArray {
    [songModelArray removeAllObjects];
    NSMutableArray *dataArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"musicModel"];
    for (NSMutableData *data in dataArray) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        SongModel *temp = [unarchiver decodeObjectForKey:@"model"];
        [songModelArray addObject:temp];
    }
}

// 归档model
- (void)archiverModel:(SongModel *)model {
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:model forKey:@"model"];
    [archiver finishEncoding];
    NSMutableArray *dataArray = [[[NSUserDefaults standardUserDefaults] valueForKey:@"musicModel"] mutableCopy];
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    [dataArray insertObject:data atIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:dataArray forKey:@"musicModel"];
}

- (NSMutableArray *)songModelArray {
    if (!_songModelArray) {
        _songModelArray = [NSMutableArray array];
    }
    return _songModelArray;
}

- (NSMutableDictionary *)downloadStateDic {
    if (!_downloadStateDic) {
        _downloadStateDic = [NSMutableDictionary dictionary];
    }
    return _downloadStateDic;
}

- (instancetype)init {
    self.midTitle = @"下载列表";
    return [super init];
}

- (UITableView *)tableV {
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64)];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.bounces = NO;
        _tableV.estimatedRowHeight = 100;
//        [_tableV registerNib:[UINib nibWithNibName:@"DownloadListTableViewCell" bundle:nil] forCellReuseIdentifier:@"downloadList"];
    }
    return _tableV;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(reloadTableView) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableV];
    [self.timer fire];
}

- (void)reloadTableView {
    [self.tableV reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    DownloadListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadList" forIndexPath:indexPath];
    DownloadListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DownloadListTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.musicDownloadButton addTarget:self action:@selector(downloadAction:) forControlEvents:(UIControlEventTouchUpInside)];
        SongModel *model = self.songModelArray[indexPath.row];
        cell.musicTitleL.text = model.SN;
        cell.musicProgressL.text = [NSString stringWithFormat:@"%.f%%", [[DownloadManager sharedInstance] progress:model.FN] *100];
        cell.musicProgressV.progress = [[DownloadManager sharedInstance] progress:model.FN];
        NSString *downloadState = [self.downloadStateDic valueForKey:model.FN];
        [cell.musicDownloadButton setTitle:[self getTitleWithDownloadState:downloadState.integerValue] forState:(UIControlStateNormal)];
    }
    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 暂停计时器
    [self.timer setFireDate:[NSDate distantFuture]];
    
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        SongModel *model = self.songModelArray[indexPath.row];
        
        // 下载列表中删除
        [[DownloadManager sharedInstance] deleteFile:model.FN];
        
        // NSUserDefault中删除
        NSMutableArray *dataArray = [[[NSUserDefaults standardUserDefaults] valueForKey:@"musicModel"] mutableCopy];
        [dataArray removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setValue:dataArray forKey:@"musicModel"];
        
        // modelArray中删除
        [self.songModelArray removeObjectAtIndex:indexPath.row];
        
        // UI中删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        
        // 打开计时器
        [self.timer setFireDate:[NSDate date]];
    }];
    return @[rowAction];
}

- (void)downloadAction:(UIButton *)sender {
    DownloadListTableViewCell *cell = (DownloadListTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableV indexPathForCell:cell];
    SongModel *model = self.songModelArray[indexPath.row];
    [[DownloadManager sharedInstance] download:model.FN progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.musicProgressV.progress = progress;
            cell.musicProgressL.text = [NSString stringWithFormat:@"%.f%%", progress * 100];
        });
    } state:^(DownloadState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [sender setTitle:[self getTitleWithDownloadState:state] forState:(UIControlStateNormal)];
            [self.downloadStateDic setValue:@(state) forKey:model.FN];
        });
    }];
}

- (NSString *)getTitleWithDownloadState:(DownloadState)state {
    switch (state) {
        case DownloadStateSuspended:
        case DownloadStateFailed: return @"开始";
        case DownloadStateStart: return @"暂停";
        case DownloadStateCompleted: return @"完成";
        default: break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
