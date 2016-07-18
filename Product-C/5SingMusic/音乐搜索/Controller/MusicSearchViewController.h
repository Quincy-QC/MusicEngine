//
//  MusicSearchViewController.h
//  Product-C
//
//  Created by UntilYou-QC on 16/7/18.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicSearchViewController : UIViewController

@end

@implementation UIScrollView (UITouchEvent)
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nextResponder touchesBegan:touches withEvent:event];
}
@end