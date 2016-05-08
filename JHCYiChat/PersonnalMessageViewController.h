//
//  PersonnalMessageViewController.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/2.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonnalMessageViewController : UIViewController<NSURLConnectionDataDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *header;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UITextField *name;
@property (retain, nonatomic) IBOutlet UITextField *email;
@property (assign,nonatomic)NSInteger index;

@property (retain,nonatomic)People *people;


@property (retain, nonatomic) IBOutlet UIButton *confirmBtn;
- (IBAction)confirmBtnClick:(UIButton *)sender;


@end
