//
//  LoginViewController.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/1.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<NSURLConnectionDataDelegate>

- (IBAction)registerClick:(UIButton *)sender;
- (IBAction)loginClick:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UITextField *userTF;
@property (retain, nonatomic) IBOutlet UITextField *passwordTF;







@end
