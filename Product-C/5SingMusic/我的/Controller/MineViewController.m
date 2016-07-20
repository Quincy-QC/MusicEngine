//
//  MineViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/19.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MineViewController.h"
#import "LoginAndRegistView.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftBtnType = @"search";
        self.btnTitleArray = [@[@"我的"] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LoginAndRegistView *loginAndRegistView = [[[NSBundle mainBundle] loadNibNamed:@"LoginAndRegistView" owner:self options:nil] firstObject];
    loginAndRegistView.frame = CGRectMake(0, 64, KScreenW, KScreenH - 64 - 49);
    loginAndRegistView.MyParentVC = (MyBaseViewController *)self;
    [self.view addSubview:loginAndRegistView];
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
