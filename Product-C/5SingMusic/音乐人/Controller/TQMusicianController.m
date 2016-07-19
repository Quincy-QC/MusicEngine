//
//  TQMusicianController.m
//  5SingMusic
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 TangQuan. All rights reserved.
//

#import "TQMusicianController.h"
#import "MusicianViewController.h"
#import "MyBaseViewController.h"
#import "MyCommonBaseViewController.h"
@interface TQMusicianController ()

@end

@implementation TQMusicianController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.leftBtnType =@"search";
         self.btnTitleArray =[[NSMutableArray alloc]initWithArray:@[@"推荐",@"新入驻",@"名人堂"]];
         self.vcClassArray =[[NSMutableArray alloc]initWithArray:@[[MusicianViewController class],[MusicianViewController class],[MusicianViewController class]]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (MyBaseViewController *vc in self.VCArray) {
        vc.myParentVC = self;
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
