//
//  MusicListCollectionViewCell.h
//  Product-C
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicListModel.h"

@interface MusicListCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *picView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic, strong) MusicListModel *model;


@end
