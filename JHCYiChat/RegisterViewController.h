//
//  RegisterViewController.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/1.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIAlertViewDelegate>


@property (retain, nonatomic) IBOutlet UITextField *userTF;

@property (retain, nonatomic) IBOutlet UITextField *passwordTF;

@property (retain, nonatomic) IBOutlet UITextField *confirmPasswordTF;

@property (retain, nonatomic) IBOutlet UITextField *nickNameTF;

@property (retain, nonatomic) IBOutlet UITextField *emailTF;

- (IBAction)confirmRegister:(UIButton *)sender;
















@end
