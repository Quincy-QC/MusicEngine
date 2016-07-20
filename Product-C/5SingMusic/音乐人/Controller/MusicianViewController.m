//
//  MusicianViewController.m
//  Product-B-again
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 刘平. All rights reserved.
//

#import "MusicianViewController.h"
#import <memory.h>
#import "MusicIanTableViewCell.h"
#import "RequestManager.h"
#import "RecommentModel.h"
#import "MyCommonBaseViewController.h"
#import "ChangeDataMusician.h"
#import "MusicPlayerViewController.h"


@interface MusicianViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) NSString *URL;
@end

@implementation MusicianViewController


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH - 64 - 49) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)updataSource {
    [SVProgressHUD show];
    [RequestManager requestWithUrlString:self.URL requestType:(requestGET) parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        self.modelArray = [RecommentModel modelConfigureJsonDic:dic];
        [self.tableView reloadData];
        
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [SVProgressHUD dismissWithDelay:0.3];
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:0.3];
        NSLog(@"error ========= %@", error);
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    NSString *title = [ChangeDataMusician shareInstance].buttonTitle;
    if ([title isEqualToString:@"推荐"]) {
        self.URL = TjMusician;
        [self updataSource];
    }
    
    if ([title isEqualToString:@"新入驻"]) {
        self.URL = NewMusician;
        [self updataSource];
    }
    
    if ([title isEqualToString:@"名人堂"]) {
        self.URL = MRT_ZOB_Musician;
        [self updataSource];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 第一次进来
    self.URL = TjMusician;
    [self updataSource];
    self.tableView.rowHeight = 150;
    [self.tableView registerClass:[MusicIanTableViewCell class] forCellReuseIdentifier:@"musciCell"];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicIanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musciCell" forIndexPath:indexPath];
    RecommentModel *model = self.modelArray[indexPath.row];
    cell.model = model;
    [cell.playButton addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

- (void)playAction:(UIButton *)sender {
    MusicIanTableViewCell *cell = (MusicIanTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    RecommentModel *model = self.modelArray[indexPath.row];
    MusicPlayerViewController *musicPlayerVC = [MusicPlayerViewController sharedMusicPlayerWithSongType:model.Song[@"SK"] songID:model.Song[@"ID"]];
    [self.myParentVC.navigationController pushViewController:musicPlayerVC animated:YES];
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
