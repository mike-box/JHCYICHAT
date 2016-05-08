//
//  FileViewController.m
//  JHCYiChat
//
//  Created by 九条桜子 on 16/4/23.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "FileViewController.h"
#import "DownloadedTableViewController.h"
#import "FileDetailViewController.h"
@interface FileViewController ()
{
    UISegmentedControl *_segmentC;
}
@end

@implementation FileViewController

static NSString * const reuseIdentifier = @"Cell";

-(void)viewWillDisappear:(BOOL)animated
{
    //    把对象存储到本地 对象要先实现NSCoding协议
    [[NSUserDefaults standardUserDefaults]setObject:self.downLoadFileArray forKey:@"downLoadFileArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

/**
 *  页面将要出现的时候从本地把数据取出来 根据本地的数据来判断哪些文件已经下载好了
 *
 *  @param animated 是否带动画效果
 */
-(void)viewWillAppear:(BOOL)animated
{
    /**
     *  如果本地存在文件数组,那么取出来(取出来默认是不可变数组 需要深拷贝以下),否则重新初始化数组
     */
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"downLoadFileArray"]) {
        _downLoadFileArray=[[[NSUserDefaults standardUserDefaults]objectForKey:@"downLoadFileArray"]mutableCopy];
    }else{
        _downLoadFileArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    
//  请求文件列表
    [[MyRequest sharedRequestBox]requestForFileListCompletion:^(bool success, NSMutableArray *pubFileArray, NSMutableArray *perFileArray) {
        if (success) {
            self.pubFileArray=pubFileArray;
            self.perFileArray=perFileArray;
            self.fileArray=_pubFileArray;
            [self.collectionView reloadData];
        }
    }];
//   显示导航栏上的控件 让segmentcontroller选中第一个
    [_segmentC setHidden:NO];
    _segmentC.selectedSegmentIndex=0;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     设置segmentController
     */
    _segmentC=[[UISegmentedControl alloc]initWithItems:@[@"公共资源",@"个人资源"]];
    _segmentC.frame=CGRectMake(85, 5, 150, 30);
    _segmentC.tag=10;
    _segmentC.selectedSegmentIndex=0;
    [_segmentC addTarget:self action:@selector(segmentedValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:_segmentC];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"download_button"] style:UIBarButtonItemStylePlain target:self action:@selector(downloadedFile)];
    // 注册单元格
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    
}

/**
 *  进入已下载文件页面
 */
-(void)downloadedFile{
    
    DownloadedTableViewController *downloadVC=[[DownloadedTableViewController alloc]init];
    [self.navigationController pushViewController:downloadVC animated:YES];
    [downloadVC release];
}

/**
 *  segmentView值改变事件
 *
 *  @param sender 无返回值
 */
-(void)segmentedValueChanged:(UISegmentedControl *)sender
{
    //    替换数据源
    if (sender.selectedSegmentIndex==0) {
        self.fileArray=self.pubFileArray;
    }else{
        self.fileArray=self.perFileArray;
    }
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
///返回区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
//返回每个区物件的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.fileArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //     清除重用单元格内容 防止重叠
    [[cell viewWithTag:1] removeFromSuperview];
    [[cell viewWithTag:2] removeFromSuperview];
    [[cell viewWithTag:3] removeFromSuperview];
    [[cell viewWithTag:4] removeFromSuperview];
    // Configure the cell
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 65)];
    imageView.tag=2;
    File *file=[self.fileArray objectAtIndex:indexPath.row];
    [imageView setImageWithURL:[NSURL URLWithString:file.image_url]];
    //    让进度条翻转90度
    imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    [cell addSubview:imageView];
    [imageView release];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 70, 65, 20)];
    label.tag=1;
    label.font=[UIFont systemFontOfSize:8];
    label.numberOfLines=0;
    label.textAlignment=NSTextAlignmentCenter;
    label.text=file.name;
    [cell addSubview:label];
    [label release];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, 65)];
    label1.alpha=0.6;
    label1.text=@"下载";
    //    查看本地文件是否存在 如果存在说明下载好了 下载好了把下载改为查看
    if ([[NSFileManager defaultManager]fileExistsAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/DownLoads/%@",file.tname]]) {
        label1.text=@"查看";
    }
    else
    {
        UIProgressView *progressView=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.tag=4;
        progressView.frame=CGRectMake(0, 32.5, 65, 2);
        //        将progressView纵向放大到和imageView一样的大小
        progressView.transform=CGAffineTransformMakeScale(1.0f,32.5f);
        progressView.alpha=0.5;
        progressView.progressTintColor=[UIColor whiteColor];
        [imageView addSubview:progressView];
        [progressView release];
    }
    label1.tag=3;
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:12];
    [cell addSubview:label1];
    [label1 release];
    return cell;
    
}

#pragma mark <UICollectionViewDelegate>

///点击物件的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    创建目的路径 保存下载好的资源
    File *file=[self.fileArray objectAtIndex:indexPath.row];
    NSString *dePath=[NSHomeDirectory() stringByAppendingFormat:@"/Documents/DownLoads/%@",file.tname];
    
    //    创建临时文件夹和下载文件夹
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/DownLoads"] withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createDirectoryAtPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/temp"] withIntermediateDirectories:YES attributes:nil error:nil];
    //    判断路径下面有没有资源 如果有资源 证明已经下载好了 那么就直接跳转到文件详情页面
    if ([fileManager fileExistsAtPath:dePath]) {
        FileDetailViewController *fileDetailVC=[[FileDetailViewController alloc]init];
        file.localPath=dePath;
        fileDetailVC.file=file;
        [self.navigationController pushViewController:fileDetailVC animated:YES];
        [fileDetailVC release];
    }
    //    临时路径
    NSString *tempPath=[NSHomeDirectory() stringByAppendingFormat:@"/Documents/temp/%@",file.tname];
    
//    开始下载
    [[MyRequest sharedRequestBox]downloadFileRequestWithDePath:dePath tempPath:tempPath file:file progressCell:[self.collectionView cellForItemAtIndexPath:indexPath] completion:^(bool success, NSData *fileData) {
        [self.downLoadFileArray addObject:fileData];
    }];
    
}

@end
