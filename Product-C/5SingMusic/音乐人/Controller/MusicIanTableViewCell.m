//
//  MusicIanTableViewCell.m
//  Product-B-again
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 刘平. All rights reserved.
//

#import "MusicIanTableViewCell.h"
#import <Masonry.h>
#import "UIImageView+AFNetworking.h"
@implementation MusicIanTableViewCell

- (void)setModel:(RecommentModel *)model {
    [self.picImage setImageWithURL:[NSURL URLWithString:model.I] placeholderImage:nil];
    self.nameLabel.text = model.NN;
    NSInteger popularityNumber = model.FCRQ.integerValue + model.YCRQ.integerValue;
    if (popularityNumber > 10000) {
        self.popularityLabel.text = [NSString stringWithFormat:@"人气：%ld 万", popularityNumber/10000];
    }else {
        self.popularityLabel.text = [NSString stringWithFormat:@"人气：%ld", popularityNumber];
    }
    self.markLabel.text = model.M;
    
    if (model.Song.count == 0) {
        self.worksLabel.text = @"最新作品：";
    }else {
    self.worksLabel.text = [NSString stringWithFormat:@"最新作品：%@",model.Song[@"SN"]];
    }
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.picImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.picImage];
        
        self.nameLabel = [[UILabel alloc ]init];
        [self.contentView addSubview:self.nameLabel];
        
        self.popularityLabel = [[UILabel alloc ] init];
        [self.contentView addSubview:self.popularityLabel];
        
        self.markLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.markLabel];
        
        self.lineView = [[UIView alloc] init];
        [self.contentView addSubview:self.lineView];
        self.lineView.backgroundColor = [UIColor colorWithRed:61/255.0 green:61/255.0 blue:61/255.0 alpha:0.5];
        
        self.worksLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.worksLabel];
        self.worksLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        
        self.addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.contentView addSubview:self.addButton];
        
        self.playButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.contentView addSubview:self.playButton];
        
        [self.addButton setImage:[UIImage imageNamed:@"musican_follow"] forState:UIControlStateNormal];
        [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.picImage.backgroundColor = [UIColor redColor];
//    self.nameLabel.backgroundColor = [UIColor redColor];
//    self.popularityLabel.backgroundColor = [UIColor yellowColor];
//    self.markLabel.backgroundColor = [UIColor greenColor];
//    self.worksLabel.backgroundColor = [UIColor orangeColor];
//    self.addButton.backgroundColor = [UIColor cyanColor];
//    self.playButton.backgroundColor = [UIColor purpleColor];
    
    [self.picImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImage.mas_right).offset(10);
        make.top.equalTo(self.picImage.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake((self.contentView.frame.size.width / 5) * 3, 20));
    }];
    
    [self.popularityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(self.picImage.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake((self.contentView.frame.size.width / 5) * 3, 20));
        
    }];
    
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.popularityLabel.mas_bottom).offset(5);
        make.left.equalTo(self.picImage.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake((self.contentView.frame.size.width / 5) * 3, 20));
        
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picImage.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);

        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width - 10, 1));
    }];
    
    
    [self.worksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.lineView.mas_bottom).offset(5);
//        make.bottom.equalTo(self.contentView).offset(-5);
        make.right.equalTo(self.contentView).offset(-((self.contentView.frame.size.width / 5) * 2 - 15));
//        make.size.height.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake((self.contentView.frame.size.width / 5) * 3, 20));
        
    }];
    
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.popularityLabel.mas_top).offset(-5);
        make.right.equalTo(self.contentView).offset(- 10);
        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width / 10, self.contentView.frame.size.width / 10));
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(self.contentView.frame.size.width / 10, self.contentView.frame.size.width / 10));
        
        
    }];
    
    
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
