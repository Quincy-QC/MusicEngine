//
//  MusicRankingListViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicRankingListViewController.h"
#import "MusicRankListModel.h"
#import "MusicRankListTableViewCell.h"
#import "DetailRankingViewController.h"
@interface MusicRankingListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mytableview;
@property (nonatomic, strong) NSMutableArray *listArray;


@end

@implementation MusicRankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestDatasource];
    [self initMytableview];
    
    // Do any additional setup after loading the view.
}

- (void)initMytableview{
    _mytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) style:(UITableViewStylePlain)];
    _mytableview.delegate = self;
    _mytableview.dataSource = self;
    _mytableview.rowHeight = 150;
    [_mytableview registerClass:[MusicRankListTableViewCell class] forCellReuseIdentifier:@"musicRankcell"];
    [self.view addSubview:_mytableview];
}

- (void)requestDatasource{
    [_listArray removeAllObjects];
    [SVProgressHUD show];
    [RequestManager requestWithUrlString:PHBUrl requestType:(requestGET) parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        _listArray = [MusicRankListModel configureWithjsonDic:dic];
        [_mytableview reloadData];
        //消除提示框
        [SVProgressHUD dismissWithDelay:0.3];
    } error:^(NSError *error) {
        [SVProgressHUD dismissWithDelay:0.3];
        NSLog(@"%@", error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicRankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicRankcell" forIndexPath:indexPath];
    cell.model = _listArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailRankingViewController *vc = [[DetailRankingViewController alloc] init];
    if (indexPath.row == 0) {
        vc.type = @"yc";
        vc.midTitle = @"原创排行榜";
    }
    if (indexPath.row == 1) {
        vc.type = @"fc";
        vc.midTitle = @"翻唱排行榜";
    }
    if (indexPath.row == 2) {
        vc.type = @"list23";
        vc.midTitle = @"新歌Top50";
    }
    if (indexPath.row == 3) {
        vc.type = @"list25";
        vc.midTitle = @"最受欢迎的歌曲";
    }
    
   vc.index =@"1";
    [self.myParentVC.navigationController pushViewController:vc animated:YES];
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
