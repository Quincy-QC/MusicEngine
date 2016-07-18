//
//  MyPlayView.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/16.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyCommonView.h"
#import "SongModel.h"

@interface MyPlayView : MyCommonView
@property (strong, nonatomic) IBOutlet UIButton *musicAboveButton;
@property (strong, nonatomic) IBOutlet UIButton *musicNextButton;

- (void)toPlayWithSong:(SongModel *)model;

@end
