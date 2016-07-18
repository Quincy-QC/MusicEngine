//
//  MyDetailBaseViewController.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyBaseViewController.h"
#import "DetailNavView.h"

@interface MyDetailBaseViewController : MyBaseViewController
@property (nonatomic,strong) NSString *midTitle;
@property (nonatomic,strong) DetailNavView *navView;
-(void)refreshMyTitle;

@end
