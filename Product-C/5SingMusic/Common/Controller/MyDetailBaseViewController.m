//
//  MyDetailBaseViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyDetailBaseViewController.h"

@interface MyDetailBaseViewController ()

@end

@implementation MyDetailBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatMyNavUI];
    // Do any additional setup after loading the view.
}

-(void)creatMyNavUI{
    //自定义导航栏
    _navView =[[DetailNavView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
    _navView.titleLabel.text =self.midTitle;
    _navView.MyParentVC =self;
    _navView.backgroundColor = KColor(239, 239, 239);
    [self.view addSubview:_navView];
}
-(void)refreshMyTitle{
    _navView.titleLabel.text =self.midTitle;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =YES;
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
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
