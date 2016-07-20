//
//  MusicRankListTableViewCell.h
//  Product-C
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicRankListModel.h"
@interface MusicRankListTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picView;
@property (nonatomic,strong) UILabel *TipLabel;
@property (nonatomic,strong) UILabel *Label1;
@property (nonatomic,strong) UILabel *Label2;
@property (nonatomic,strong) UILabel *Label3;
@property (nonatomic,strong) UILabel *Label4;
@property (nonatomic,strong) MusicRankListModel *model;


@end
