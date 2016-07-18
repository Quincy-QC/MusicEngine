//
//  MusicViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicRecommendViewController.h"
#import "MusicRankingListViewController.h"
#import "MusicListViewController.h"

@interface MusicViewController ()

@end

@implementation MusicViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.leftBtnType = @"search";
        self.btnTitleArray = [[NSMutableArray alloc] initWithArray:@[@"推荐", @"歌单", @"排行版"]];
        self.vcClassArray = [[NSMutableArray alloc] initWithArray:@[[MusicRecommendViewController class], [MusicListViewController class], [MusicRankingListViewController class]]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (MyBaseViewController *vc in self.VCArray) {
        vc.myParentVC = self;
    }
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
