//
//  DetailTableViewCell.m
//  Product-C
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _numLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 20, 25)];
        _numLabel.font =[UIFont systemFontOfSize:16];
        _numLabel.textColor =[UIColor grayColor];
        [self.contentView addSubview:_numLabel];
        
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(30, 5, 250, 25)];
        _nameLabel.font =[UIFont systemFontOfSize:16];
        _nameLabel.textColor =[UIColor grayColor];
        [self.contentView addSubview:_nameLabel];
        
        _singerLabel =[[UILabel alloc]initWithFrame:CGRectMake(30,30, 250, 20)];
        _singerLabel.font =[UIFont systemFontOfSize:12];
        _singerLabel.textColor =[UIColor grayColor];
        [self.contentView addSubview:_singerLabel];
        _bfView =[[UIImageView alloc]initWithFrame:CGRectMake(KScreenW-60, 5, 40, 40)];
        [_bfView setImage:[UIImage imageNamed:@"play"]];
        [self.contentView addSubview:_bfView];
    }
    return self;
}

- (void)setModel:(DetailMusicModel *)model{
    _nameLabel.text = model.SN;
    NSDictionary *userDic = model.user;
    _singerLabel.text = userDic[@"NN"];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
