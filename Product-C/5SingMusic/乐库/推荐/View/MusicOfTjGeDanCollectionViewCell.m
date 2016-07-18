//
//  MusicOfTjGeDanCollectionViewCell.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicOfTjGeDanCollectionViewCell.h"

@interface MusicOfTjGeDanCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UILabel *playCountL;

@end

@implementation MusicOfTjGeDanCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)cellConfiguredByModel:(ModelOfTjGeDan *)model {
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.Picture]];
    self.titleL.text = model.Title;
    self.playCountL.text = [NSString stringWithFormat:@"%@", model.PlayCount];
}

@end
