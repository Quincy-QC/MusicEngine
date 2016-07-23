//
//  MyCurrentSongView.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyCurrentSongView.h"
#import "MyCurrentSongTableViewCell.h"

@interface MyCurrentSongView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *songArray;
@property (nonatomic, strong) UILabel *numberL;

@end

@implementation MyCurrentSongView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.songTableView];
    }
    return self;
}

- (UITableView *)songTableView {
    if (!_songTableView) {
        _songTableView = [[UITableView alloc] initWithFrame:self.bounds style:(UITableViewStylePlain)];
        _songTableView.backgroundColor = KColorWithAlpha(250, 250, 250, 0.1);
        _songTableView.dataSource = self;
        _songTableView.delegate = self;
        [_songTableView registerNib:[UINib nibWithNibName:@"MyCurrentSongTableViewCell" bundle:nil] forCellReuseIdentifier:@"currentSong"];
    }
    return _songTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCurrentSongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"currentSong" forIndexPath:indexPath];
    SongModel *model = self.songArray[indexPath.row];
    [cell cellConfiguredByModel:model withIndex:indexPath.row];
    cell.myTableView = self;
    cell.backgroundColor = KColorWithAlpha(250, 250, 250, 0.1);
    if (indexPath.row == [MusicPlayerViewController sharedMusicPlayerWithSongType:nil songID:nil].myPlayIndex) {
        cell.backgroundColor = KColorWithAlpha(140, 140, 255, 0.1);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createHeaderView];
}

- (UIView *)createHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KRealValue(40))];
    headerView.backgroundColor = KColorWithAlpha(250, 250, 250, 0.1);
    
    [headerView addSubview:self.numberL];
    [self.numberL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(10);
        make.centerY.equalTo(headerView);
    }];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SongModel *model = self.songArray[indexPath.row];
    MusicPlayerViewController *musicPlayerVC = [MusicPlayerViewController sharedMusicPlayerWithSongType:nil songID:nil];
    musicPlayerVC.songID = model.ID;
    musicPlayerVC.songType = model.SK;
    musicPlayerVC.myPlayIndex = indexPath.row;
    if (musicPlayerVC.songType && musicPlayerVC.songID) {
        [musicPlayerVC createDataWithType:@"1"];
    }
    MyCurrentSongTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = KColorWithAlpha(140, 140, 255, 0.1);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCurrentSongTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = KColorWithAlpha(250, 250, 250, 0.1);
}

-(void)ConfigMyViewWithArray:(NSArray *)array{
    self.songArray =[[NSMutableArray alloc]initWithArray:array];
    self.numberL.text =[NSString stringWithFormat:@"%ld 首歌曲",self.songArray.count];
    [self.songTableView reloadData];
}

- (UILabel *)numberL {
    if (!_numberL) {
        _numberL = [[UILabel alloc] init];
        self.numberL.textColor = KColor(200, 200, 200);
    }
    return _numberL;
}

@end
