//
//  LoginViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/19.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *unameTF;
@property (strong, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)loginAction:(UIButton *)sender {
    [self loginRequestData];
}

- (void)loginRequestData {
    [SVProgressHUD show];
    [RequestManager requestWithUrlString:[NSString stringWithFormat:LOGIN_URL, self.unameTF.text, self.pwdTF.text] requestType:requestGET parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        id success = [dic valueForKey:@"success"];
        BOOL isSuccess = (BOOL)success;
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [SVProgressHUD dismissWithDelay:0.3];
        } else {
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
            [SVProgressHUD dismissWithDelay:0.3];
        }
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [SVProgressHUD dismissWithDelay:0.3];
        NSLog(@"error ======== %@", error);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
