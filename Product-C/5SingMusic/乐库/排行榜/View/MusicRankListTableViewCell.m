//
//  MusicRankListTableViewCell.m
//  Product-C
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MusicRankListTableViewCell.h"

@implementation MusicRankListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _picView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 70, 70)];
        [self.contentView addSubview:_picView];
        
        _TipLabel =[[UILabel alloc]initWithFrame:CGRectMake(90,20, KScreenW-140, 20)];
        _TipLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_TipLabel];
        
        _Label1 =[[UILabel alloc]initWithFrame:CGRectMake(90,40, KScreenW-140, 20)];
        _Label1.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_Label1];
        
        _Label2 =[[UILabel alloc]initWithFrame:CGRectMake(90,60, KScreenW-140, 20)];
        _Label2.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_Label2];
        
        _Label3 =[[UILabel alloc]initWithFrame:CGRectMake(90,80, KScreenW-140, 20)];
        _Label3.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_Label3];
        
        _Label4 =[[UILabel alloc]initWithFrame:CGRectMake(90,100, KScreenW-140, 20)];
        _Label4.font =[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_Label4];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setModel:(MusicRankListModel *)model{
    [_picView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"2"] completed:nil];
    _TipLabel.text= model.name;
    //NSLog(@"==== %ld", model.songs.count);
    _Label1.text =[NSString stringWithFormat:@"1 %@",model.songs[0]];
    if (model.songs.count >= 2) {
         _Label2.text =[NSString stringWithFormat:@"2 %@",model.songs[1]];
         _Label3.text =[NSString stringWithFormat:@"3 %@",model.songs[2]];
         _Label4.text =[NSString stringWithFormat:@"4 %@",model.songs[3]];
    
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
