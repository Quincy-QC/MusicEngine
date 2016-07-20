//
//  DynamicViewController.m
//  PlayMusic1
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

#import "DynamicViewController.h"
#import "LoginAndRegistView.h"

@interface DynamicViewController ()
@property (nonatomic, strong) LoginAndRegistView *loginAndRegistView;
@end

@implementation DynamicViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    self.loginAndRegistView.MyParentVC = (MyBaseViewController *)self.myParentVC;
    [super viewWillAppear:animated];
}

- (void)createUI {
    self.loginAndRegistView = [[[NSBundle mainBundle] loadNibNamed:@"LoginAndRegistView" owner:self options:nil] firstObject];
    self.loginAndRegistView.frame = CGRectMake(0, -64, KScreenW, KScreenH);
    [self.view addSubview:self.loginAndRegistView];
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
