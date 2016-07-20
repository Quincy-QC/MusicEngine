//
//  TQBtn.m
//  5SingMusic
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 TangQuan. All rights reserved.
//

#import "TQBtn.h"

@implementation TQBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, 20, contentRect.size.height);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(20, 0, contentRect.size.width-20, contentRect.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
