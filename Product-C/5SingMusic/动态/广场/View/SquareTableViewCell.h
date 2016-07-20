//
//  SquareTableViewCell.h
//  SingMusic
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseViewController.h"
#import "TQBtn.h"
#import "ModelOfSquare.h"

@interface SquareTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *songTypeLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *moreButton;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) TQBtn *commentBtn;
@property (nonatomic,strong) TQBtn *likeBtn;

@property (nonatomic,strong) UIButton *bfButton;
@property (nonatomic,strong) UIButton *songButton;
@property (nonatomic,strong) UIView *songView;
@property (nonatomic,strong) UIView *TextView;
@property (nonatomic,strong) NSDictionary *songDic;
@property (nonatomic,strong) MyBaseViewController *myVc;

-(void)configCellWithModel:(ModelOfSquare *)model;

@end
