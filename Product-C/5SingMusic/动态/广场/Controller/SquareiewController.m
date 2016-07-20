//
//  SquareiewController.m
//  Product-C
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "SquareiewController.h"
#import "ModelOfSquare.h"
#import "SquareTableViewCell.h"

@interface SquareiewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SquareiewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _isFirstAppear = YES;
    }
    return self;
}

#pragma mark ------------ 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (UITableView *)tableV {
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, KScreenW, KScreenH - 64 - 49 - 40) style:(UITableViewStylePlain)];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.rowHeight = 180;
        [self.view addSubview:_tableV];
    }
    return _tableV;
}


#pragma mark ------------ 数据解析
- (void)getDataWithString:(NSString *)str {
    
    [self.dataArr removeAllObjects];
    // 显示加载框
    [SVProgressHUD show];
     [RequestManager requestWithUrlString:str requestType:requestGET parDic:nil finish:^(NSData *data) {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
         self.dataArr = [ModelOfSquare modelConfigureWithJson:dic];
         [self.tableV reloadData];
         // 消除加载框
         [SVProgressHUD dismissWithDelay:0.5];

     } error:^(NSError *error) {
         [SVProgressHUD dismissWithDelay:0.5];
         NSLog(@"%@", error);
     }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_isFirstAppear == YES) {
        [self getDataWithString:DT_GC_ZR];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    [self createUI];

}

#pragma mark ------------ tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ModelOfSquare *model = self.dataArr[indexPath.row];
    NSString *type = [NSString stringWithFormat:@"%d", model.category.intValue];
    SquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:type];
    if (!cell) {
        cell = [[SquareTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:type];
    }
    cell.myVc = self;
    [cell configCellWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark ------------ 创建UI
- (void)createUI {
    
    _btnArr = [NSMutableArray array];
    NSArray *array = @[@"最热", @"最新"];
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:array[i] forState:(UIControlStateNormal)];
        [button setTitleColor:MYGREENCOLOR forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateSelected)];
        // 一上来就加载最热
        if (i == 0) {
            button.selected = YES;
            [button setBackgroundColor:[UIColor greenColor]];
            [self getDataWithString:DT_GC_ZR];
        } else {
            button.backgroundColor = KColor(225, 225, 225);
        }
        button.layer.cornerRadius = 5;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.frame = CGRectMake(80 + i * (KScreenW - 160) / 2, 5, (KScreenW - 160) / 2, 30);
        button.tag = 100 + i;
        [button addTarget:self action:@selector(sort:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:button];
        [_btnArr addObject:button];
    }
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(0, 39, KScreenW, 1);
    btn.backgroundColor = KColor(225, 225, 225);
    [self.view addSubview:btn];
}

- (void)sort:(UIButton *)btn {
    if (btn.tag == 100) {
        [self getDataWithString:DT_GC_ZR];
    } else {
        [self getDataWithString:DT_GC_ZX];
    }
    for (UIButton *button in _btnArr) {
        if (button == btn) {
            button.selected = YES;
            button.backgroundColor = [UIColor greenColor];            
        } else {
            button.selected = NO;
            button.backgroundColor = MYGRAYCOLOR;
        }
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
