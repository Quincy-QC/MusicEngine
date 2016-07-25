//
//  MessageLoginViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/20.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MessageLoginViewController.h"

@interface MessageLoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (strong, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (strong, nonatomic) IBOutlet UIButton *sendMessageButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger second;

@end
@implementation MessageLoginViewController
- (instancetype)init {
    self.hidesBottomBarWhenPushed = YES;
    return [super init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendMessageAction:(UIButton *)sender {
    if (self.phoneNumTF.text.length != 11) {
        [self createAlertController:@"请输入正确的手机号码"];
        return;
    }
    [self changeButtonWithSender:sender];

    /*
    *  @from                    v1.1.1
    *  @brief                   获取验证码(Get verification code)
    *
    *  @param method            获取验证码的方法(The method of getting verificationCode)
    *  @param phoneNumber       电话号码(The phone number)
    *  @param zone              区域号，不要加"+"号(Area code)
    *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
    *  @param result            请求结果回调(Results of the request)
    */
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumTF.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
            [self createAlertController:@"获取验证码成功"];
        } else {
            NSLog(@"错误信息:%@", error);
            [self createAlertController:[NSString stringWithFormat:@"错误信息:%@", error]];
        }
    }];
}

- (void)changeButtonWithSender:(UIButton *)sender {
    sender.enabled = NO;
    sender.backgroundColor = KColor(255, 255, 255);
    self.second = 60;
    [self.timer setFireDate:[NSDate date]];
}

- (void)changeButtonTitle {
    self.second -= 1;
    if (self.second == 0) {
        [self.timer setFireDate:[NSDate distantFuture]];
        [self.sendMessageButton setTitle:@"发送验证" forState:(UIControlStateNormal)];
        self.sendMessageButton.enabled = YES;
        self.sendMessageButton.backgroundColor = KColor(0, 160, 255);
        return;
    }
    self.sendMessageButton.titleLabel.text = [NSString stringWithFormat:@"%ld秒后再次发送", self.second];
    [self.sendMessageButton setTitle:[NSString stringWithFormat:@"%ld秒后再次发送", self.second] forState:(UIControlStateNormal)];
}

- (IBAction)loginAction:(UIButton *)sender {
    if (self.verificationCodeTF.text.length != 4) {
        [self createAlertController:@"请输入验证码"];
        return;
    }
    /**
     * @from               v1.1.1
     * @brief              提交验证码(Commit the verification code)
     *
     * @param code         验证码(Verification code)
     * @param phoneNumber  电话号码(The phone number)
     * @param zone         区域号，不要加"+"号(Area code)
     * @param result       请求结果回调(Results of the request)
     */
    [SMSSDK commitVerificationCode:self.verificationCodeTF.text phoneNumber:self.phoneNumTF.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSLog(@"验证成功");
        }
        else
        {
            NSLog(@"错误信息：%@",error);
            [self createAlertController:[NSString stringWithFormat:@"错误信息:%@", error]];
        }
    }];
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeButtonTitle) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)createAlertController:(NSString *)message {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [self presentViewController:alertC animated:YES completion:^{
        [self performSelector:@selector(dismissAlertC) withObject:self afterDelay:0.8];
    }];
}

- (void)dismissAlertC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
    self.timer = nil;
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
