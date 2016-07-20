//
//  MusicListCollectionViewCell.m
//  Product-C
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicListCollectionViewCell.h"

@implementation MusicListCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    self.backgroundColor = KColor(239, 239, 239);
    self.picView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 150)];
    [self.contentView addSubview:self.picView];
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150,self.contentView.frame.size.width, 20)];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.textColor= [UIColor grayColor];
    [self.contentView addSubview:self.nameLabel];
    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, self.contentView.frame.size.width, 10)];
    self.numLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.numLabel];
}

- (void)setModel:(MusicListModel *)model{
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"2.png"] completed:nil];
    self.nameLabel.text =model.listName;
    self.numLabel.text =[NSString stringWithFormat:@"%@",model.playcount];
}



@end
