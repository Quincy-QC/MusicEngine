//
//  MusicSearchViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicSearchViewController.h"
#import "ModelOfMusicSearch.h"
#import "MusicPlayerViewController.h"

@interface MusicSearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate>
@property (nonatomic, strong) UISearchController *searchC;
@property (nonatomic, strong) UITableView *searchResultsTV;
@property (nonatomic, strong) NSMutableArray *songArray;

@end

@implementation MusicSearchViewController
- (UISearchController *)searchC {
    if (!_searchC) {
        _searchC = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchC.delegate = self;
        _searchC.searchResultsUpdater = self;
        _searchC.searchBar.delegate = self;
        _searchC.hidesNavigationBarDuringPresentation = NO;
        _searchC.obscuresBackgroundDuringPresentation = NO;
        _searchC.searchBar.showsCancelButton = YES;
        _searchC.searchBar.translucent = YES;
    }
    return _searchC;
}

- (UITableView *)searchResultsTV {
    if (!_searchResultsTV) {
        _searchResultsTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, KScreenW, KScreenH - 20) style:(UITableViewStylePlain)];
        _searchResultsTV.delegate = self;
        _searchResultsTV.dataSource = self;
        _searchResultsTV.tableHeaderView = self.searchC.searchBar;
        [_searchResultsTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    }
    return _searchResultsTV;
}

- (NSMutableArray *)songArray {
    if (!_songArray) {
        _songArray = [NSMutableArray array];
    }
    return _songArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"reuse"];
    }
    ModelOfMusicSearch *model = self.songArray[indexPath.row];
    cell.textLabel.text = model.songName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ModelOfMusicSearch *model = self.songArray[indexPath.row];
    MusicPlayerViewController *musicPlayerVC = [MusicPlayerViewController sharedMusicPlayerWithSongType:model.type songID:model.songId];
    [self dismissViewControllerAnimated:YES completion:^{
        [self dismissViewControllerAnimated:YES completion:^{
//            [self presentViewController:musicPlayerVC animated:YES completion:nil];
        }];
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [self requestData];
}

// 实时更新搜索结果
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
}

- (void)requestData {
    [self.songArray removeAllObjects];
    [SVProgressHUD show];
    NSString *songName = [self.searchC.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", songName);
    [RequestManager requestWithUrlString:[NSString stringWithFormat:SEARCH_TEXT, songName] requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.songArray = [ModelOfMusicSearch modelConfiguredByJson:dic];
        [self.searchResultsTV reloadData];
        [SVProgressHUD showInfoWithStatus:@"加载完成"];
        [SVProgressHUD dismissWithDelay:0.3];
    } error:^(NSError *error) {
        [SVProgressHUD dismissWithDelay:0.3];
        NSLog(@"error =========== %@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.searchResultsTV];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchC.searchBar endEditing:YES];
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
