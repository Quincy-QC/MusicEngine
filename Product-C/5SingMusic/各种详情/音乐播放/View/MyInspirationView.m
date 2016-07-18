//
//  MyInspirationView.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyInspirationView.h"

@interface MyInspirationView ()
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UILabel *myLyricL;

@end

@implementation MyInspirationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollV];
        [self.scrollV addSubview:self.myLyricL];
        
//        [self.myLyricL mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(10);
//            make.right.equalTo(self).offset(-10);
//            make.top.equalTo(self).offset(10);
//        }];
    }
    return self;
}

- (UIScrollView *)scrollV {
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] initWithFrame:self.bounds];
    }
    return _scrollV;
}

- (UILabel *)myLyricL {
    if (!_myLyricL) {
        _myLyricL = [[UILabel alloc] init];
        _myLyricL.numberOfLines = 0;
        _myLyricL.lineBreakMode = NSLineBreakByWordWrapping;
        _myLyricL.textColor = KColor(239, 239, 239);
        _myLyricL.textAlignment = NSTextAlignmentCenter;
        _myLyricL.font = [UIFont systemFontOfSize:15];
        _myLyricL.text = @"这个家伙太懒了,没有写灵感哦!";
    }
    return _myLyricL;
}

- (void)configureMyInspirationViewWithString:(NSString *)string {
    if ([string isEqualToString:@""] || !string) {
        self.myLyricL.text = @"这个家伙太懒了,没有写灵感哦!";
    } else {
        self.myLyricL.text = string;
    }
    CGSize size = [self.myLyricL sizeThatFits:CGSizeMake(KScreenW - 20, MAXFLOAT)];
    self.myLyricL.frame = CGRectMake(10, 10, KScreenW - 20, size.height);
    self.scrollV.contentSize = CGSizeMake(size.width, size.height + 20);
}

@end
