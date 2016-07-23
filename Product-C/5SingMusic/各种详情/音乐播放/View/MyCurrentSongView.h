//
//  MyCurrentSongView.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyCommonView.h"

@interface MyCurrentSongView : MyCommonView
@property (nonatomic, strong) UITableView *songTableView;
-(void)ConfigMyViewWithArray:(NSArray *)array;

@end
