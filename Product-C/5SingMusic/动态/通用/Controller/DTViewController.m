//
//  DTViewController.m
//  PlayMusic1
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

#import "DTViewController.h"
#import "SquareiewController.h"
#import "DynamicViewController.h"
#import "MyBaseViewController.h"

@interface DTViewController ()

@end

@implementation DTViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.leftBtnType = @"write";
//        self.btnTitleArray = [@[@"广场",@"动态"] mutableCopy];
//        self.vcClassArray = [@[[SquareiewController class], [DynamicViewController class]]mutableCopy];
        self.btnTitleArray = [@[@"广场"] mutableCopy];
        self.vcClassArray = [@[[SquareiewController class]] mutableCopy];
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
