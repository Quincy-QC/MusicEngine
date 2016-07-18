//
//  DetailTableViewCell.h
//  Product-C
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailMusicModel.h"

@interface DetailTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *singerLabel;
@property (nonatomic,strong) UIImageView *bfView;

@property (nonatomic, strong) DetailMusicModel *model;


@end
