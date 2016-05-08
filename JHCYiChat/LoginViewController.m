//
//  LoginViewController.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/1.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ChatRoomViewController.h"
#import "NewsViewController.h"
#import "FileViewController.h"
#import "PersonViewController.h"
@interface LoginViewController ()
{
    NSMutableData *_data;
}
@end

@implementation LoginViewController

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
    _data=[[NSMutableData alloc]initWithCapacity:0];
    self.title=@"登录";
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkRegister:) name:@"registSuccess" object:nil];
}

/**
 *  注册完成通知的方法
 *
 *  @param notification 通知
 */
-(void)checkRegister:(NSNotification *)notification
{
    self.userTF.text=[[notification userInfo]objectForKey:@"name"];
    self.passwordTF.text=[[notification userInfo]objectForKey:@"password"];
}
/**
 *  点击注册
 *
 *  @param sender 注册按钮
 */
- (IBAction)registerClick:(UIButton *)sender {
    RegisterViewController *registerVC=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    [registerVC release];
}

/**
 *  点击登录
 *
 *  @param sender 按钮
 */
- (IBAction)loginClick:(UIButton *)sender {
    
    [[MyRequest sharedRequestBox]loginRequest:self.userTF.text withPassword:self.passwordTF.text completion:^(bool success, NSDictionary *resultDic) {
        if ([[resultDic objectForKey:@"result"] isEqualToString:@"1"]) {
            
            NSDate *valiDate=[NSDate dateWithTimeIntervalSinceNow:2000];
            NSDateFormatter *formatter=[[[NSDateFormatter alloc]init]autorelease];
            [formatter setDateFormat:@"mm分ss秒"];
            NSString *access_token=[resultDic objectForKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults]setObject:valiDate forKey:@"valiDate"];
            [[NSUserDefaults standardUserDefaults]setObject:access_token forKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            ChatRoomViewController *chatVC=[[[ChatRoomViewController alloc]init]autorelease];
            chatVC.tabBarItem=[[[UITabBarItem alloc]initWithTitle:@"主页" image:[UIImage imageNamed:@"main"] selectedImage:[UIImage imageNamed:@"main"]]autorelease];
            UINavigationController *chatNav=[[[UINavigationController alloc]initWithRootViewController:chatVC]autorelease];
            
            NewsViewController *newsVC=[[[NewsViewController alloc]init]autorelease];
            newsVC.tabBarItem=[[[UITabBarItem alloc]initWithTitle:@"新闻" image:[UIImage imageNamed:@"news"] selectedImage:[UIImage imageNamed:@"news"]]autorelease];
            UINavigationController *newsNav=[[[UINavigationController alloc]initWithRootViewController:newsVC]autorelease];
            
            
            UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
            layout.itemSize=CGSizeMake(65, 95);
            layout.sectionInset=UIEdgeInsetsMake(20, 35, 20, 35);
            layout.minimumLineSpacing=20;
            
            
            FileViewController *fileVC=[[[FileViewController alloc]initWithCollectionViewLayout:layout ]autorelease];
            [layout release];
            
            fileVC.tabBarItem=[[[UITabBarItem alloc]initWithTitle:@"文件" image:[UIImage imageNamed:@"file"] selectedImage:[UIImage imageNamed:@"file"]]autorelease];
            UINavigationController *fileNav=[[[UINavigationController alloc]initWithRootViewController:fileVC]autorelease];
            
            PersonViewController *personVC=[[[PersonViewController alloc]init]autorelease];
            personVC.tabBarItem=[[[UITabBarItem alloc]initWithTitle:@"个人" image:[UIImage imageNamed:@"person"] selectedImage:[UIImage imageNamed:@"person"]]autorelease];
            
            UINavigationController *personNav=[[[UINavigationController alloc]initWithRootViewController:personVC]autorelease];
            
            UITabBarController *tabBar=[[[UITabBarController alloc]init]autorelease];
            tabBar.viewControllers=@[chatNav,newsNav,fileNav,personNav];
            
            UIWindow *window=[UIApplication sharedApplication].delegate.window;
            
            window.rootViewController=tabBar;
            
        }
    }];
    
}
- (void)dealloc {
    [_userTF release];
    [_passwordTF release];
    [super dealloc];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}





@end
