//
//  MusicOfTjItemsDetailViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicOfTjItemsDetailViewController.h"

@interface MusicOfTjItemsDetailViewController ()

@end

@implementation MusicOfTjItemsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
}

- (void)createWebView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];
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
