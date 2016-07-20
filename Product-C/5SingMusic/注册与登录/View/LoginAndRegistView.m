//
//  LoginAndRegistView.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/19.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "LoginAndRegistView.h"
#import "LoginViewController.h"

@implementation LoginAndRegistView

- (IBAction)loginAction:(UIButton *)sender {
    [self.MyParentVC.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
}

- (IBAction)RegistAction:(UIButton *)sender {
}

@end
