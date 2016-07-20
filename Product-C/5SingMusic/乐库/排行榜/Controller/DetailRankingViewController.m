//
//  DetailRankingViewController.m
//  Product-C
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "DetailRankingViewController.h"
#import "DetailRankModel.h"
#import "DetailTableViewCell.h"
#import "MusicPlayerViewController.h"
@interface DetailRankingViewController ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation DetailRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestDatasource];
    [self initMyTableview];
    // Do any additional setup after loading the view.
}

- (void)initMyTableview{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH) style:(UITableViewStylePlain)];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.rowHeight = 60;
    [_myTableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"detailRankCell"];
    [self.view addSubview:_myTableView];
}

- (void)requestDatasource{
    [_listArray removeAllObjects];
    [SVProgressHUD show];
    NSString *url = [NSString stringWithFormat:DetailPHB,_type];
    [RequestManager requestWithUrlString:url requestType:(requestGET) parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        _listArray = [DetailRankModel configureWithJsonDic:dic];
        [_myTableView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [SVProgressHUD dismissWithDelay:0.3];
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
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
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailRankCell" forIndexPath:indexPath];
    cell.model = _listArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailRankModel *model = self.listArray[indexPath.row];
    MusicPlayerViewController *musicPlayerVC = [MusicPlayerViewController sharedMusicPlayerWithSongType:model.SK songID:model.ID];
    [self.navigationController pushViewController:musicPlayerVC animated:YES];
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
