//
//  ViewController.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/1.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "ChatRoomViewController.h"
#import "NewsViewController.h"
#import "FileViewController.h"
#import "PersonViewController.h"
@interface ViewController ()
{
    UIImageView *_imageView1;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    

	LoginViewController *loginVC=[[LoginViewController alloc]init];
    _imageView1=[[UIImageView alloc]initWithFrame:self.view.frame];
    
    _imageView1.image=[UIImage imageNamed:@"default"];
    [self.view addSubview:_imageView1];
   [UIView animateWithDuration:0 animations:^{
       _imageView1.alpha=0.5;
   } completion:^(BOOL finished) {
       
       if ([self isNeedLogin]) {
           [UIView transitionFromView:self.view toView:loginVC.view duration:0 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
               UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:loginVC];
               [[UIApplication sharedApplication]keyWindow].rootViewController=nav;
               [nav release];
           }];
           [_imageView1 removeFromSuperview];
       }else
       {
           
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
           
           FileViewController *fileVC=[[[FileViewController alloc]initWithCollectionViewLayout:layout]autorelease];
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

-(BOOL)isNeedLogin
{
    NSString *access_token=[[NSUserDefaults standardUserDefaults]objectForKey:ACCESS_TOKEN_KEY];
    NSDate *safeDate=[[NSUserDefaults standardUserDefaults]objectForKey:@"valiDate"];
    NSComparisonResult result=[safeDate compare:[NSDate date]];
    
    if (access_token&&result==NSOrderedDescending) {
        NSLog(@"没过期，免登陆");
        return NO;
    }
    NSLog(@"过期，需要登录");
    return YES;
}


@end
