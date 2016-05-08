//
//  PersonnalMessageViewController.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/2.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "PersonnalMessageViewController.h"

@interface PersonnalMessageViewController ()

@end

@implementation PersonnalMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人信息";
    // Do any additional setup after loading the view from its nib.
    
    
    if (self.index==0) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"上传头像" style:UIBarButtonItemStylePlain target:self action:@selector(updateHeader)];
        self.confirmBtn.hidden=NO;
        self.name.enabled=YES;
        self.email.enabled=YES;
    }
    [self.header setImageWithURL:[NSURL URLWithString:self.people.headerUrl] placeholderImage:[UIImage imageNamed:@"head"]];
    self.name.text=self.people.nickName;
    self.email.text=self.people.email;
    self.titleLabel.text=self.people.name;
    
    
}

-(void)updateHeader
{
    UIImagePickerController *picker=[[[UIImagePickerController alloc]init]autorelease];
    [self presentViewController:picker animated:YES completion:nil];
    //    相册是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    picker.allowsEditing=YES;
    picker.delegate=self;
    
}

#pragma 处理系统相册的代理方法
//选择一张图片的时候调用 info保存了原始的图片和修改之后的图片

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    获取编辑之后的图片
    UIImage *newImage=[info objectForKey:UIImagePickerControllerEditedImage];
    //    把图片转化成NSData
    NSData *imageData=UIImagePNGRepresentation(newImage);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[MyRequest sharedRequestBox]uploadHeaderRequestHeaderData:imageData completion:^(bool success) {
        if(success)
        {
            ALERT_SHOW(@"修改成功");
        }
    }];
    
    self.header.image= newImage;
    
    
    
}

- (void)dealloc {
    [_header release];
    [_name release];
    [_email release];
    [_titleLabel release];
    [_confirmBtn release];
    [super dealloc];
}
- (IBAction)confirmBtnClick:(UIButton *)sender {
    [[MyRequest sharedRequestBox]updatePersonalMessageWithNickName:self.name.text email:self.email.text completion:^(bool success) {
        if (success) {
            ALERT_SHOW(@"修改成功");
        }
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
