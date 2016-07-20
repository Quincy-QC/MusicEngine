//
//  SquareTableViewCell.m
//  SingMusic
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

#import "SquareTableViewCell.h"
#import "MusicPlayerViewController.h"

@implementation SquareTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        if ([reuseIdentifier isEqualToString:@"1"]) {
            [self createUIWithSongAndText];
        } else if ([reuseIdentifier isEqualToString:@"3"]) {
            [self createUIOnlyText];
        } else if ([reuseIdentifier isEqualToString:@"6"]) {
            [self createUIOnlyPic];
        }
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = [self.nameLabel.text boundingRectWithSize:CGSizeMake(KScreenW / 2, 0) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width;
    self.nameLabel.frame = CGRectMake(60, 5, width, 20);
    CGFloat marginX = CGRectGetMaxX(self.nameLabel.frame);
    self.songTypeLabel.frame = CGRectMake(marginX + 10, 5, KScreenW / 2, 20);
    
}

- (void)initUI {
    
    _picView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    _picView.layer.cornerRadius = 25;
    _picView.layer.masksToBounds = YES;
    [self.contentView addSubview:_picView];
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = MYGREENCOLOR;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nameLabel];
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 200, 15)];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_timeLabel];
    _commentBtn = [TQBtn buttonWithType:(UIButtonTypeSystem)];
    _commentBtn.frame = CGRectMake(KScreenW / 2, 155, KScreenW / 4, 20);
    [_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_commentBtn];
    _likeBtn = [TQBtn buttonWithType:(UIButtonTypeSystem)];
    _likeBtn.frame = CGRectMake(KScreenW / 4 * 3, 155, KScreenW / 4, 20);
    [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_likeBtn];
    
}

// 有歌曲和文字
- (void)createUIWithSongAndText {
    // 上传类型
    _songTypeLabel = [[UILabel alloc] init];
    _songTypeLabel.font = [UIFont systemFontOfSize:12];
    _songTypeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_songTypeLabel];
    // 内容
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 50, KScreenW - 65, 50)];
    _contentLabel.numberOfLines = 3;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_contentLabel];
    // 放播放图标和歌名的底视图
    _songView = [[UIView alloc] initWithFrame:CGRectMake(60, 100, KScreenW - 65, 30)];
    [self.contentView addSubview:_songView];
    // 播放图标
    _bfButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _bfButton.frame = CGRectMake(0, 0, 30, 30);
    [_bfButton setImage:[UIImage imageNamed:@"play_dynamic"] forState:(UIControlStateNormal)];
    [_bfButton addTarget:self action:@selector(playMusic) forControlEvents:(UIControlEventTouchUpInside)];
    [_songView addSubview:_bfButton];
    // 歌曲名
    _songButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _songButton.frame = CGRectMake(30, 0, KScreenW - 95, 30);
    _songButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
    _songButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_songButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [_songButton addTarget:self action:@selector(playMusic) forControlEvents:(UIControlEventTouchUpInside)];
    [_songView addSubview:_songButton];
}

// 点击 btn 播放音乐
- (void)playMusic {
    NSString *type;
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString * B = [numberFormatter stringFromNumber:[_songDic objectForKey:@"SongType"]];
    
    if ([ B isEqualToString:@"2"]) {
        type =@"fc";
    }else{
        type =@"yc";
    }
    MusicPlayerViewController *playVC=[MusicPlayerViewController sharedMusicPlayerWithSongType:type songID:[_songDic objectForKey:@"BelongID"]];
    [_myVc.myParentVC.navigationController pushViewController:playVC animated:YES];
}

// 只有文字
- (void)createUIOnlyText {
    // 内容
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 50, KScreenW - 65, 50)];
    _contentLabel.numberOfLines = 3;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_contentLabel];
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 100, 50)];
    _imgView.backgroundColor = MYGRAYCOLOR;
    [self.contentView addSubview:_imgView];
}

// 只有图片
- (void)createUIOnlyPic {
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, 100, 100)];
    _imgView.backgroundColor = MYGRAYCOLOR;
    [self.contentView addSubview:_imgView];
}


- (void)configCellWithModel:(ModelOfSquare *)model {
    [_picView setImageWithURL:[NSURL URLWithString:[model.user valueForKey:@"I"]]];
    _nameLabel.text = [model.user valueForKey:@"NN"];
    _timeLabel.text = [self getTimeLabelText:model.createtime];
    _songDic = [NSMutableDictionary dictionary];
    NSDictionary *dic = [self getDicWithString:model.content];
    _songDic = dic;
    NSNumber *comment = [dic objectForKey:@"Comments"];
    NSNumber *like = [dic objectForKey:@"Likes"];
    [_commentBtn setTitle:[NSString stringWithFormat:@"%d", comment.intValue] forState:(UIControlStateNormal)];
    [_likeBtn setTitle:[NSString stringWithFormat:@"%d", like.intValue] forState:(UIControlStateNormal)];

    // caregory = 1 是有歌曲  =3 是没有歌曲有文字和图片的  =6 是只有图片的
    NSInteger categroy =model.category.integerValue;
    if (categroy ==1) {
        _contentLabel.text = dic[@"Content"];
        [_songButton setTitle:dic[@"SongName"] forState:(UIControlStateNormal)];
        NSNumber *type = [dic objectForKey:@"SongType"];
        if ([type isEqual:@(1)]) {
            _songTypeLabel.text = @"上传了一首原创";
        } else {
            _songTypeLabel.text = @"上传了一首翻唱";
        }
    } else if ([model.category isEqual:@(3)]) {
        _contentLabel.text = [dic valueForKey:@"Content"];
        [_imgView setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"FileName"]]];
    } else if ([model.category isEqual:@(6)]) {
        [_imgView setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"FileName"]]];
    }
}

-(NSString *)getTimeLabelText:(NSNumber *)timeNumber{
    //由于数据给的不是从1970年开始算的，因此根据推算得到下面
    long long  time =timeNumber.longLongValue/10000000 -62167161000+365*86400;
    long long nowTime = [self getNowTime];
    //时间差
    long long sTime =nowTime-time;
    if (sTime <60) {
        return @"刚刚";
    }
    if (sTime<3600){
        return [NSString stringWithFormat:@"%lld分钟前",sTime/60];
    }
    if (sTime<86400) {
        return [NSString stringWithFormat:@"%lld小时前",sTime/3600];
    }
    if (sTime<2*86400) {
        return @"昨天";
    }
    return [self getDateString:time];
}

-(NSString *)getDateString:(long long)timeN{
    NSString *time =[NSString stringWithFormat:@"%lld",timeN];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[time intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

-(long long)getNowTime{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    
    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter1 setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    return (long long)[date timeIntervalSince1970];
}

-(NSDictionary *)getDicWithString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        NSLog(@"%@", err);
        return nil;
    }
    return dic;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
