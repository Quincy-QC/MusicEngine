//
//  DetailViewController.m
//  Product-C
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailMusicModel.h"
#import "DetailTableViewCell.h"
#import "HeadVIew.h"
#import "MusicPlayerViewController.h"
@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableview;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) HeadVIew *headview;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestheadViewDatasource];
    [self requestTableviewDatasource];
    [self initheadview];
    [self initMytableview];
    
    // Do any additional setup after loading the view.
}

- (void)initheadview{
    _headview =[[HeadVIew alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 350)];
    _headview.MyParentVC = self;
    [_headview.bfBtn addTarget:self action:@selector(playAll) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)playAll {
    if (self.listArray.count > 0) {
        MusicPlayerViewController *musicPlayerVC = [MusicPlayerViewController sharedMusicPlayerWithSongType:nil songID:nil];
        for (NSInteger i = self.listArray.count - 1; i >= 0; i--) {
            DetailMusicModel *model = self.listArray[i];
            if (i == 0) {
                musicPlayerVC.songType = model.SK;
                musicPlayerVC.songID = model.ID;
                if (musicPlayerVC.songID && musicPlayerVC.songID) {
                    [musicPlayerVC createDataWithType:@"2"];
                }
            } else {
                [musicPlayerVC.songArray insertObject:model atIndex:0];
            }
        }
        [self.navigationController pushViewController:musicPlayerVC animated:YES];
    }
}

- (void)initMytableview{
    _myTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64) style:(UITableViewStylePlain)];
    _myTableview.delegate = self;
    _myTableview.dataSource = self;
    _myTableview.rowHeight = 80;
    _myTableview.tableHeaderView = _headview;
    [_myTableview registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"detailCell"];
    [self.view addSubview:_myTableview];
}

- (void)requestheadViewDatasource{
    [SVProgressHUD show];
    [RequestManager requestWithUrlString:[NSString stringWithFormat:GEDAN_TOP, _listID] requestType:(requestGET) parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSDictionary *dicc = dic[@"data"];
        DetailMusicModel *model = [DetailMusicModel initWithDict:dicc];
        _headview.model = model;
        
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [SVProgressHUD dismissWithDelay:0.3];
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:0.3];
        NSLog(@"error ======== %@", error);
    }];
}

- (void)requestTableviewDatasource{
    [SVProgressHUD show];
    [RequestManager requestWithUrlString:[NSString stringWithFormat:GEDAN_DETAIL, _listID] requestType:(requestGET) parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        _listArray = [DetailMusicModel scrollModelConfigureWithJsonDic:dic];
        [_myTableview reloadData];
        
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [SVProgressHUD dismissWithDelay:0.3];
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:0.3];
        NSLog(@"error ======== %@", error);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    cell.numLabel.text =[NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.model = _listArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailMusicModel *model = self.listArray[indexPath.row];
    MusicPlayerViewController *musicVC = [MusicPlayerViewController sharedMusicPlayerWithSongType:model.SK songID:model.ID];
    [self.navigationController pushViewController:musicVC animated:YES];
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
