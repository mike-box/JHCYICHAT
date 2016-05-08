
//  FileDetailViewController.m
//  JHCYiChat
//
//  Created by 九条桜子 on 16/4/24.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "FileDetailViewController.h"


@interface FileDetailViewController ()
{
    UIScrollView *_scrollView;
}
@end

@implementation FileDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"文件详情";
    [[self.navigationController.navigationBar viewWithTag:10]setHidden:YES];
    self.view.backgroundColor=[UIColor whiteColor];
    if ([self.file.mimetype isEqualToString:@"audio/x-mpeg"]||[self.file.mimetype isEqualToString:@"null"]) {
        [self showMedia];
    }
    else{
        [self showOther];
    }
}

/**
 *  展示音视频文件
 */
-(void)showMedia
{
    MPMoviePlayerViewController *playerC=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:self.file.localPath]];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _scrollView.backgroundColor=[UIColor whiteColor];
    _scrollView.contentSize=CGSizeMake(320, 480);
    [self.view addSubview:_scrollView];
    playerC.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    playerC.moviePlayer.repeatMode = MPMovieRepeatModeOne;
    playerC.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    playerC.view.frame=CGRectMake(0, 0, 320, 370);
    [_scrollView addSubview:playerC.view];
}
/**
 *  展示音视频以外的其他文件
 */
-(void)showOther
{
    UIWebView *webView=[[[UIWebView alloc]initWithFrame:self.view.bounds]autorelease];
    webView.autoresizesSubviews=YES;
    NSLog(@"%@",self.file.localPath);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.file.localPath]]];
    [self.view addSubview:webView];
}
- (void)dealloc
{
    [_scrollView release];

    [super dealloc];
}

@end
