//
//  MusicListViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicListViewController.h"
#import "MusicListModel.h"
#import "MusicListCollectionViewCell.h"
#import "DetailViewController.h"

@interface MusicListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UICollectionView *myCollectView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSString *listType;
@property (nonatomic, strong) NSString *sortType;
@property (nonatomic, assign) BOOL firstAppear;
@property (nonatomic, strong) UIView *typeView;
@property (nonatomic, strong) UIImageView *lineImgV;
@property (nonatomic, strong) UILabel *sortL;
@property (nonatomic, strong) UIButton *changeSortBtn;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) UIButton *NewButton;
@property (nonatomic, strong) UIButton *HotButton;
@property (nonatomic, strong) UILabel *lineL;
@property (nonatomic, assign) BOOL isSelect;

@end

@implementation MusicListViewController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _listType = @"流行";
        _sortType = @"2";
        _firstAppear = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _typeArray = [GenDanTypes mutableCopy];
    [self initButton];
    [self initMyTableView];
    [self initMyCollectView];
    [self requestdataSource];
    //[self initTypeView];
    
    // Do any additional setup after loading the view.
}

- (void)requestdataSource{
    [_listArray removeAllObjects];
    [SVProgressHUD show];
    NSString *str = [[NSString stringWithFormat:GDTypeUrl,_listType, _sortType] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [RequestManager requestWithUrlString:str requestType:(requestGET) parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        _listArray = [MusicListModel scrollModelConfigureWithJsonDic:dic];
        [_myCollectView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [SVProgressHUD dismissWithDelay:0.3];
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:0.3];
        NSLog(@"%@", error);
    }];
}

- (void)initButton{
    _NewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _NewButton.frame = CGRectMake(KScreenW - 100, 0, 45, 30);
    _NewButton.tintColor = [UIColor blackColor];
    //_NewButton.backgroundColor = [UIColor whiteColor];
    [_NewButton setTitle:@"最新" forState:(UIControlStateNormal)];
    [_NewButton addTarget:self action:@selector(NewAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    _HotButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    _HotButton.frame = CGRectMake(KScreenW - 45, 0, 45, 30);
    _HotButton.tintColor = MYGREENCOLOR;
    //_HotButton.backgroundColor = [UIColor whiteColor];
    [_HotButton setTitle:@"最热" forState:(UIControlStateNormal)];
    [_HotButton addTarget:self action:@selector(hotAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //_HotButton.selected = YES;
    
    _lineL = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW-50, 0, 1, 30)];
    _lineL.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_NewButton];
    [self.view addSubview:_HotButton];
    [self.view addSubview:_lineL];
}

- (void)NewAction:(UIButton *)button{
    _sortType = @"1";
    button.tintColor = MYGREENCOLOR;
    //button.selected = YES;
    _HotButton.tintColor = [UIColor blackColor];
    [self requestdataSource];
}

- (void)hotAction:(UIButton *)button{
    _sortType = @"2";
    button.tintColor = MYGREENCOLOR;
    //button.selected = YES;
    _NewButton.tintColor = [UIColor blackColor];
    [self requestdataSource];
}
- (void)initMyTableView{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 85, KScreenH) style:(UITableViewStylePlain)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 50;
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    [self.view addSubview:_myTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _typeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = GenDanTypes[indexPath.row];
    if (_firstAppear) {
        NSInteger selectIndex = 0;
        NSIndexPath *selectIndexpath = [NSIndexPath indexPathForRow:selectIndex inSection:0];
        [tableView selectRowAtIndexPath:selectIndexpath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _listType = GenDanTypes[indexPath.row];
    _sortType = @"2";
    _HotButton.tintColor = MYGREENCOLOR;
    _NewButton.tintColor = [UIColor blackColor];
    [self requestdataSource];
}

- (void)initMyCollectView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _myCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(85, 30, KScreenW - 80, KScreenH - 64) collectionViewLayout:layout];
    _myCollectView.backgroundColor = [UIColor whiteColor];
    _myCollectView.delegate = self;
    _myCollectView.dataSource = self;
    [_myCollectView registerClass:[MusicListCollectionViewCell class] forCellWithReuseIdentifier:@"musicListCell"];
    [self.view addSubview:_myCollectView];
}

//- (void) initTypeView{
//    _typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
//    _typeView.backgroundColor = [UIColor whiteColor];
//    
//    _lineImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 1, 20)];
//    _lineImgV.backgroundColor = [UIColor greenColor];
//    [_typeView addSubview:_lineImgV];
//    
//    _sortL = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 20)];
//    _sortL.text = _listType;
//    [_sortL setTextAlignment:NSTextAlignmentLeft];
//    [_typeView addSubview:_sortL];
//    
//    _changeSortBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    _changeSortBtn.frame = CGRectMake(KScreenW - 100, 5, 80, 20);
//    [_changeSortBtn setTitle:@"选择分类" forState:(UIControlStateNormal)];
//    [_changeSortBtn addTarget:self action:@selector(changeTypeAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    _changeSortBtn.tintColor = [UIColor blackColor];
//    
//    [_typeView addSubview:_changeSortBtn];
//    [self.view addSubview:_typeView];
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _listArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KScreenW - 120) / 2, 185);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

// 纵向距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

// 横向距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MusicListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"musicListCell" forIndexPath:indexPath];
    
    cell.model = _listArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MusicListModel *model = _listArray[indexPath.row];
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.listID = model.listId;
    vc.midTitle = model.listName;
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
