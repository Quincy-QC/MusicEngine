//
//  HeadVIew.m
//  Product-C
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "HeadVIew.h"

@implementation HeadVIew

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _bgview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 290)];
        [self addSubview:_bgview];
        
        _GrayView =[[UIView alloc]initWithFrame:CGRectMake(0, 260, KScreenW, 30)];
        _GrayView.backgroundColor =[UIColor colorWithRed:100/255 green:100/255 blue:100/255 alpha:0.4];
        [self addSubview:_GrayView];
        
        _iconView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
        [_GrayView addSubview:_iconView];
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(30, 5, 200, 20)];
        _nameLabel.textColor =[UIColor whiteColor];
        [_GrayView addSubview:_nameLabel];
        
        _likeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _likeBtn.frame =CGRectMake(KScreenW-100, 5, 20, 20);
        [_likeBtn setImage:[UIImage imageNamed:@"SCfaviour"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"SCfaviour_selected"] forState:UIControlStateSelected];
        [_GrayView addSubview:_likeBtn];
        
        _shareBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame =CGRectMake(KScreenW-70, 5, 20, 20);
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [_GrayView addSubview:_shareBtn];
        
        _bfBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _bfBtn.frame =CGRectMake(KScreenW-40, 0, 30, 30);
        [_bfBtn setImage:[UIImage imageNamed:@"play_b"] forState:UIControlStateNormal];
        [_GrayView addSubview:_bfBtn];
        
        _TextLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 290, KScreenW-20, 40)];
        _TextLabel.font =[UIFont systemFontOfSize:15];
        _TextLabel.textColor =[UIColor grayColor];
        _TextLabel.numberOfLines =2;
        [self addSubview:_TextLabel];
        
        _TypeLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 330, KScreenW-20, 20)];
        _TypeLabel.font =[UIFont systemFontOfSize:15];
        _TypeLabel.textColor =[UIColor grayColor];
        
        [self addSubview:_TypeLabel];

    }
    return self;
}

- (void)setModel:(DetailMusicModel *)model{
    [_bgview sd_setImageWithURL:[NSURL URLWithString:model.P] placeholderImage:[UIImage imageNamed:@"2"] completed:nil];
    _TextLabel.text =model.C;
    _TypeLabel.text =model.L;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[model.user objectForKey:@"i"]] placeholderImage:[UIImage imageNamed:@"2"] completed:nil];
    _nameLabel.text =[model.user objectForKey:@"NN"];
}


@end
