//
//  MusicOfDayTableViewCell.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicOfDayTableViewCell.h"

@interface MusicOfDayTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UILabel *contentL;

@end

@implementation MusicOfDayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfiguredByModel:(ModelOfTjDAY *)model {
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.Picture]];
    self.titleL.text = model.RecommendName;
    self.contentL.text = model.RecommendWords;
}

@end
