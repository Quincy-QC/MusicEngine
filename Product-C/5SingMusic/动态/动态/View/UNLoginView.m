//
//  UNLoginView.m
//  PlayMusic1
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

#import "UNLoginView.h"


@implementation UNLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 40, KScreenW - 200, 200)];
    imageV.image = [UIImage imageNamed:@"LoginBB"];
    [self addSubview:imageV];
    
    NSArray *arr = @[@"登录", @"注册"];
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(80, 260 + i *(30 + 30), KScreenW - 160, 40);
        [button setTitle:arr[i] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        button.tag = 100 + i;
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        if (i == 0) {
            button.backgroundColor = MYGREENCOLOR;
            
        } else {
            button.backgroundColor = [UIColor blueColor];
        }
        [self addSubview:button];
        
    }
}

- (void)click:(UIButton *)btn {
    
    if (btn.tag == 100) {
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
