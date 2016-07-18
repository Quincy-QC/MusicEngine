//
//  MusicOfTjItemsTableViewCell.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicOfTjItemsTableViewCell.h"

@interface MusicOfTjItemsTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation MusicOfTjItemsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfiguredByModel:(ModelOfTjItems *)model {
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.ImgUrl]];
    self.titleL.text = model.Title;
}

@end
