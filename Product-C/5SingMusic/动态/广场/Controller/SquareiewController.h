//
//  SquareiewController.h
//  Product-C
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"

@interface SquareiewController : MyBaseViewController

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *btnArr;;
@property (nonatomic, assign) BOOL isFirstAppear;



@end
