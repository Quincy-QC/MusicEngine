//
//  RootTabBarViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "MusicViewController.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.tabBar.translucent = NO;
    [self initVC];
    // Do any additional setup after loading the view.
}

- (void)initVC {
    // 创建子标签
    [self createControllersWithTitle:@"乐库" image:@"musicbox_normal.png" selectedImage:@"musicbox_press.png" className:[MusicViewController class]];
}

- (void)createControllersWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectImage className:(Class)class {
    UIViewController *vc = [[class alloc] init];
    vc.title = title;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
    navC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KColor(26, 179, 0)} forState:(UIControlStateSelected)];
    [self addChildViewController:navC];
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
