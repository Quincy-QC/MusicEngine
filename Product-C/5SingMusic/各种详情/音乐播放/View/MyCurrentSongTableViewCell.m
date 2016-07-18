//
//  MyCurrentSongTableViewCell.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyCurrentSongTableViewCell.h"

@interface MyCurrentSongTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UIButton *downLoadButton;

@end

@implementation MyCurrentSongTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellConfiguredByModel:(SongModel *)model withIndex:(NSInteger)index {
    self.titleL.text = [NSString stringWithFormat:@"%ld %@-%@", index + 1, model.SN, model.NN];
}

- (IBAction)downLoadAction:(UIButton *)sender {
}

@end
