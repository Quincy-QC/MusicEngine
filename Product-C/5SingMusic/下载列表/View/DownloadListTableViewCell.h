//
//  DownloadListTableViewCell.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/21.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *musicTitleL;
@property (strong, nonatomic) IBOutlet UIProgressView *musicProgressV;
@property (strong, nonatomic) IBOutlet UILabel *musicProgressL;
@property (strong, nonatomic) IBOutlet UIButton *musicDownloadButton;

@end
