//
//  MyCommonBaseViewController.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCommonBaseViewController : UIViewController
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) NSMutableArray *btnTitleArray; //导航栏中间按钮标题数组
@property (nonatomic,strong) NSString *leftBtnType; //导航栏左按钮类型
@property (nonatomic,strong) NSMutableArray *btnArray;//导航栏中间按钮数组
@property (nonatomic,strong) UIScrollView *myScrollView;//显示页面的scrollView
@property (nonatomic,strong) NSMutableArray *vcClassArray;//用来创建存放在scrollView里的 vc的类型数组
@property (nonatomic,strong) NSMutableArray *VCArray;

@end
