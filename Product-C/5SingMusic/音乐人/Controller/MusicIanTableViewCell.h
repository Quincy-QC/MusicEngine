//
//  MusicIanTableViewCell.h
//  Product-B-again
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 刘平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommentModel.h"
@interface MusicIanTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picImage;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *popularityLabel;

@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *worksLabel;

@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) RecommentModel *model;
@end
