//
//  HeadVIew.h
//  Product-C
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyCommonView.h"
#import "DetailMusicModel.h"
@interface HeadVIew : MyCommonView

@property (nonatomic, strong) UIImageView *bgview;
@property (nonatomic, strong) UIView *GrayView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *bfBtn;
@property (nonatomic, strong) UILabel *TextLabel;
@property (nonatomic, strong) UILabel *TypeLabel;
@property (nonatomic, strong) DetailMusicModel *model;



@end
