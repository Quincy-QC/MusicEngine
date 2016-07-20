//
//  MyLoginSucessViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/20.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyLoginSucessViewController.h"

@interface MyLoginSucessViewController ()

@end

@implementation MyLoginSucessViewController

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
    // Do any additional setup after loading the view.
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
