//
//  MyCommonBaseViewController.m
//  Product-C
//
//  Created by UntilYou-QC on 16/7/15.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "MyCommonBaseViewController.h"

@interface MyCommonBaseViewController ()  <UIScrollViewDelegate>

@end

@implementation MyCommonBaseViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatMyNavUI];
    [self creatMyScrollUI];
    // Do any additional setup after loading the view.
}

//根据子类VC的属性创建自定义导航栏
-(void)creatMyNavUI{
    //自定义导航栏
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
    _navView.backgroundColor = KColor(239, 239, 239);
    [self.view addSubview:_navView];
    
    //左侧按钮
    if ([self.leftBtnType isEqualToString:@"search"]) {
        UIButton *leftButton =[self creatButtonWithFrame:CGRectMake(5, 25, 30, 30) Image:@"search_btn_normal" SelectImage:@"search_btn_press" SuperView:_navView];
        [leftButton addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if([self.leftBtnType isEqualToString:@"write"]){
        UIButton *leftButton =[self creatButtonWithFrame:CGRectMake(5, 25, 30, 30) Image:@"write" SelectImage:@"writed" SuperView:_navView];
        [leftButton addTarget:self action:@selector(write:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //  右侧按钮
    UIButton *rightButton =[self creatButtonWithFrame:CGRectMake(KScreenW-35, 25, 30, 30) Image:@"music6" SelectImage:@"music6" SuperView:_navView];
    [rightButton addTarget:self action:@selector(listenMusic:) forControlEvents:UIControlEventTouchUpInside];
    
    //中间标签按钮
    _btnArray =[[NSMutableArray alloc]init];
    CGFloat x =(KScreenW-80-self.btnTitleArray.count*60)/(self.btnTitleArray.count+1);
    for (int i = 0; i<self.btnTitleArray.count; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(40+x+i*(60+x), 25, 60, 30);
        [btn setTitle:self.btnTitleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font =[UIFont systemFontOfSize:14];
        [btn setTitleColor:KColor(26, 179, 0) forState:UIControlStateSelected];
        if (i == 0) {
            btn.selected =YES;
            btn.titleLabel.font =[UIFont boldSystemFontOfSize:18];
        }
        [btn addTarget:self action:@selector(midBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setAdjustsImageWhenDisabled:NO];
        [_navView addSubview:btn];
        [_btnArray addObject:btn];
    }
    
}

-(void)creatMyScrollUI{
    _VCArray =[[NSMutableArray alloc]init];
    _myScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH)];
    for (int i = 0; i<self.vcClassArray.count; i++) {
        UIViewController *vc =[[self.vcClassArray[i] alloc]init];
        vc.view.frame=CGRectMake(i*KScreenW, 0, KScreenW, KScreenH);
        [_VCArray addObject:vc];
        UIViewController *vc2 =_VCArray[i];
        [_myScrollView addSubview:vc2.view];
    }
    _myScrollView.contentSize =CGSizeMake(_btnTitleArray.count*KScreenW, KScreenH);
    _myScrollView.contentOffset =CGPointZero;
    _myScrollView.pagingEnabled =YES;
    _myScrollView.delegate =self;
    [self.view addSubview:_myScrollView];
    
}

#pragma mark --_myscrollView代理方法
//滑动结束代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    for (int i =0 ; i<self.btnArray.count; i++) {
        CGFloat x =i*KScreenW;
        UIButton *btn =self.btnArray[i];
        NSLog(@"%f ,%f",x,_myScrollView.contentOffset.x);
        if (x == _myScrollView.contentOffset.x) {
            btn.selected =YES;
            btn.titleLabel.font =[UIFont boldSystemFontOfSize:18];
            [self viewWillAppearByIndex:i];
        }else{
            btn.selected =NO;
            btn.titleLabel.font =[UIFont systemFontOfSize:14];
        }
    }
}

-(void)viewWillAppearByIndex:(NSInteger)index{
    UIViewController *vc =_VCArray[index];
    [vc viewWillAppear:YES];
}

#pragma mark --封装的一个创建button方法
-(UIButton *)creatButtonWithFrame:(CGRect)frame Image:(NSString *)image SelectImage:(NSString *)selectImage SuperView:(UIView *)view{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [view addSubview:button];
    return button;
}

#pragma mark --leftBtn点击事件
//-(void)search:(UIButton *)sender{
//    MySearchMusicController *search =[[MySearchMusicController alloc]init];
//    [self presentViewController:search animated:YES completion:^{
//        
//    }];
//}
//-(void)write:(UIButton *)sender{
//    
//}
//#pragma mark --rightBtn点击事件
//-(void)listenMusic:(UIButton *)sender{
//    PlayMusicController *play =[PlayMusicController sharePlayMusicViewWithSongType:NULL AndSongId:NULL];
//    [self.navigationController pushViewController:play animated:YES];
//}
#pragma mark --midBtn点击事件
-(void)midBtnClick:(UIButton *)sender{
    for (int i =0; i<_btnTitleArray.count; i++) {
        if ([sender.titleLabel.text isEqualToString:_btnTitleArray[i]]) {
            [UIView animateWithDuration:0.2 animations:^{
                _myScrollView.contentOffset=CGPointMake(i*KScreenW, 0);
            }];
            sender.selected =YES;
            sender.titleLabel.font =[UIFont boldSystemFontOfSize:18];
            [self viewWillAppearByIndex:i];
        }else{
            UIButton *btn =_btnArray[i];
            btn.selected =NO;
            btn.titleLabel.font =[UIFont systemFontOfSize:14];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =YES;
    self.navView.hidden =NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navView.hidden =YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
