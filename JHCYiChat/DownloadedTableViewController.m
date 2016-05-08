//
//  DownloadedTableViewController.m
//  JHCYiChat
//
//  Created by 九条桜子 on 16/4/23.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "DownloadedTableViewController.h"
#import "FileDetailViewController.h"
@interface DownloadedTableViewController ()

@end

@implementation DownloadedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
//    隐藏导航栏上的segmentController
    [[self.navigationController.navigationBar viewWithTag:10]setHidden:YES];
    /**
     *  从本地取出来的时候是NSData格式的数据,需要使用的话需要先解码
     (mutableCopy)深拷贝 默认取出来的是不可变数组 加上这一句就会变成可变数组
     */
    _downloadFileArray=[[[NSUserDefaults standardUserDefaults]objectForKey:@"downLoadFileArray"]mutableCopy];
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"已下载文件";
    self.tableView.rowHeight=80;
    
//    注册单元格
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.downloadFileArray.count;
}

#pragma mark 设置单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    File *file=[NSKeyedUnarchiver unarchiveObjectWithData:[self.downloadFileArray objectAtIndex:indexPath.row]];
    
    //  重用之前先把上面的控件移除掉  防止发生重叠现象
    [[cell viewWithTag:1]removeFromSuperview];
    [[cell viewWithTag:2]removeFromSuperview];
    [[cell viewWithTag:3]removeFromSuperview];
    
    //图片
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 60, 60)];
    [imageView1 setImageWithURL:[NSURL URLWithString:file.image_url]];
    imageView1.tag=1;
    [cell addSubview:imageView1];
    [imageView1 release];
    //标题
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 5, 200, 30)];
    titleLabel.tag=2;
    titleLabel.font=[UIFont boldSystemFontOfSize:14];
    titleLabel.text=file.name;
    [cell addSubview:titleLabel];
    [titleLabel release];
    //摘要
    UILabel *describeLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 40, 240, 40)];
    describeLabel.tag=3;
    describeLabel.font=[UIFont systemFontOfSize:12];
    describeLabel.numberOfLines=0;
    describeLabel.text=file._description;
    [cell addSubview:describeLabel];
    [describeLabel release];
    return cell;
}
#pragma mark 点击单元格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    把数据线解码成file对象 然后再使用
    File *file=[NSKeyedUnarchiver unarchiveObjectWithData:[self.downloadFileArray objectAtIndex:indexPath.row]];
    FileDetailViewController *fileDetailVC=[[FileDetailViewController alloc]init];
    fileDetailVC.file=file;
    [self.navigationController pushViewController:fileDetailVC animated:YES];
    [fileDetailVC release];
}
#pragma mark 设置删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark 滑动删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  把当前要删除的文件对象从数组中取出来并解码 取出文件在本地存储的路径 
        然后把它从数组中移除 立即更新本地数据 然后根据刚才取出的路径把本地存放的文件删除,刷新表
     */
    File *file=[NSKeyedUnarchiver unarchiveObjectWithData:[self.downloadFileArray objectAtIndex:indexPath.row]];
    NSString *localPath=file.localPath;
    [self.downloadFileArray removeObjectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults]setObject:self.downloadFileArray forKey:@"downLoadFileArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    [fileManager removeItemAtPath:localPath error:nil];
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}






@end
