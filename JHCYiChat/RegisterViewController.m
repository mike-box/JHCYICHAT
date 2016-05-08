//
//  RegisterViewController.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/1.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    NSMutableData *_data;
}
@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _data=[[NSMutableData alloc]initWithCapacity:0];
}



- (void)dealloc {
    [_data release];
    [_userTF release];
    [_passwordTF release];
    [_confirmPasswordTF release];
    [_nickNameTF release];
    [_emailTF release];
    [super dealloc];
}
/**
 *  确认注册
 *
 *  @param sender button
 */
- (IBAction)confirmRegister:(UIButton *)sender {
    
    [[MyRequest sharedRequestBox]registerRequest:self.userTF.text password:self.passwordTF.text nickName:self.nickNameTF.text email:self.emailTF.text completion:^(bool success) {
        if (success) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"registSuccess" object:self userInfo:@{@"name": self.userTF.text,@"password":self.passwordTF.text}];
        [self.navigationController popViewControllerAnimated:YES];
    }
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}




@end
