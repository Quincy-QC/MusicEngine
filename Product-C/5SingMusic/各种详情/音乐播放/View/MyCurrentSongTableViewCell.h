//
//  MyCurrentSongTableViewCell.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongModel.h"

@interface MyCurrentSongTableViewCell : UITableViewCell

- (void)cellConfiguredByModel:(SongModel *)model withIndex:(NSInteger)index;

@end
