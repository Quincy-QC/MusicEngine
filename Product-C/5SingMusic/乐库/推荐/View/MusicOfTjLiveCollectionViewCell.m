//
//  MusicOfTjLiveCollectionViewCell.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicOfTjLiveCollectionViewCell.h"

@interface MusicOfTjLiveCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UIImageView *liveStateV;
@property (strong, nonatomic) IBOutlet UILabel *audienceL;
@property (strong, nonatomic) IBOutlet UILabel *nickNameL;
@property (strong, nonatomic) IBOutlet UILabel *timeL;

@end

@implementation MusicOfTjLiveCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)cellConfiguredByModel:(ModelOfTjLive *)model {
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgPath]];
    self.audienceL.text = [NSString stringWithFormat:@"观众:%@", model.audience];
    self.audienceL.backgroundColor = [KColor(239, 239, 239) colorWithAlphaComponent:0.4];
    self.nickNameL.text = model.nickName;
    self.timeL.text = [NSString stringWithFormat:@"%@%@", model.week, model.time];
    if ([model.type isEqualToString:@"LIVE"]) {
        [self.liveStateV setImage:[UIImage imageNamed:@"Live_LivingTip"]];
    }else if([model.type isEqualToString:@"TRAILER"]){
        [self.liveStateV setImage:[UIImage imageNamed:@"Live_TrailerTip"]];
    }else if([model.type isEqualToString:@"RECOMMEND"]){
        [self.liveStateV setImage:[UIImage imageNamed:@"Live_recommendTip"]];
    }
}

@end
