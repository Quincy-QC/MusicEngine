//
//  CarouselView.h
//  Product-A
//
//  Created by UntilYou-QC on 16/6/24.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <UIKit/UIKit.h>

// 自动时间
#define kInterval 2
@interface CarouselView : UIView
// 图片点击block回调
@property (nonatomic, copy) void(^imageClick)(NSInteger index);

// 传入frame和装有网址的数组
- (instancetype)initWithFrame:(CGRect)frame imageURLs:(NSArray *)imageURLs;

@end
