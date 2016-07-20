//
//  SendDynamicViewController.m
//  PlayMusic1
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 zhangyang. All rights reserved.
//

#import "SendDynamicViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface SendDynamicViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITextView *textV;
@property (nonatomic, strong) UILabel *plachL;
@property (nonatomic, strong) UIButton *addImgBtn;
@property (nonatomic, strong) UILabel *numberL;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UIImagePickerController *pick;


@end

@implementation SendDynamicViewController


- (void)createUI {
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    imageV.backgroundColor = KColor(65, 110, 110);
    [self.view addSubview:imageV];
    
    self.textV = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, KScreenW - 20, 200)];
    self.textV.layer.cornerRadius = 4;
    self.textV.layer.masksToBounds = YES;
    self.textV.backgroundColor = [UIColor whiteColor];
    self.textV.delegate = self;
    self.textV.font = [UIFont systemFontOfSize:20];
    self.textV.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    [self.view addSubview:self.textV];
    
    self.plachL = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, KScreenW, 20)];
    self.plachL.alpha = 0.5;
    self.plachL.text = @"输入自己想说的话吧!";
    [self.textV addSubview:self.plachL];
    
    self.numberL = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW - 130, self.textV.frame.size.height - 10, 120, 20)];
    self.count = 200;
    self.numberL.alpha = 0.5;
    self.numberL.text = [NSString stringWithFormat:@"还能输入%ld字", self.count];
    [self.view addSubview:self.numberL];
    

    self.addImgBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.addImgBtn.frame = CGRectMake(110, self.textV.frame.origin.y + self.textV.frame.size.height + 10, 100, 80);
    [self.addImgBtn setImage:[UIImage imageNamed:@"timeline_relationship_icon_addattention"] forState:(UIControlStateNormal)];
    [self.addImgBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.addImgBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.addImgBtn setTitle:@"添加照片" forState:(UIControlStateNormal)];
    [self.addImgBtn addTarget:self action:@selector(addImg) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.addImgBtn];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:1 target:self action:@selector(popAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:1 target:self action:@selector(sendDynamic)];
    self.navigationController.navigationBar.translucent = NO;
    
    [self createUI];
    
}

- (void)popAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------------ textView 代理
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.plachL.hidden = YES;
    return YES;
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    NSLog(@"%ld", range.location);
//    if (range.location >= 10) {
//        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"只能输入200字" message:nil preferredStyle:1];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:1 handler:nil];
//        [alertC addAction:action];
//        [self presentViewController:alertC animated:YES completion:nil];
//
//        return NO;
//    }
//    if ([text isEqualToString:@"\n"]) {
//        return NO;
//    }
//    else {
//        return YES;
//    }
//}

/*
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.count = 10 - textView.text.length;
    if (self.count <= 0 && textView.text.length >= 10) {
//        self.count = 0;
        self.textV.text = [textView.text substringToIndex:10];
        self.count = 10 - textView.text.length;
        return YES;
        
    } else {
        self.count = 10 - textView.text.length;
        self.numberL.text = [NSString stringWithFormat:@"%ld", self.count];
        NSLog(@"----------------%ld", self.count);
        return YES;
    }
}
*/

//- (void)textViewDidChange:(UITextView *)textView {
//    
//    self.count = 200 - textView.text.length;
//    self.numberL.text = [NSString stringWithFormat:@"还能输入%ld字", self.count];
//}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (self.count <= 0 && textView.text.length >= 200) {
        
        self.textV.text = [textView.text substringToIndex:200];
        self.count = 200 - textView.text.length;
        [self aaa];
    } else {
        self.count = 200 - textView.text.length;
        self.numberL.text = [NSString stringWithFormat:@"%ld", self.count];
        NSLog(@"-----%ld", self.count);
    }
}

- (void)aaa {
    if (self.count <= 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"只能输入150字" message:nil preferredStyle:1];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:1 handler:nil];
        [alertC addAction:action];
        [self presentViewController:alertC animated:YES completion:nil];
        
        return;
    }
    
    self.numberL.text = [NSString stringWithFormat:@"%ld", self.count];
    NSLog(@"----------------%ld", self.count);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.textV resignFirstResponder];
}

#pragma mark ------------ 添加图片
- (void)addImg {
    
    [self.addImgBtn setTitle:@"更改照片" forState:(UIControlStateNormal)];
    self.pick = [[UIImagePickerController alloc] init];
    self.pick.delegate = self;
    self.pick.allowsEditing = YES;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (self.pick.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
            [self presentViewController:self.pick animated:YES completion:nil];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}



//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        NSString *filePath;
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        //创建一个选择后图片的小图标放在下方
        UIImageView *smallimage = [[UIImageView alloc] initWithFrame: CGRectMake(10, 220, 80, 80)];
        
        smallimage.image = image;
        //加在视图中
        [self.view addSubview:smallimage];
    }
}

//
- (void)sendDynamic {
    
    
}











//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    UIImage *image = info[UIImagePickerControllerEditedImage];
//    if (!image) {
//        image = image;
//    }
//    [self.addImgBtn setImage:image forState:(UIControlStateNormal)];
//    self.addImgBtn.titleLabel.alpha = 0;
//    [self dismissViewControllerAnimated:YES completion:nil];
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
