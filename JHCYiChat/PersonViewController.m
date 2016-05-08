//
//  PersonViewController.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/1.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "PersonViewController.h"
#import "LoginViewController.h"
#import "PersonnalMessageViewController.h"
@interface PersonViewController ()
{
    UITableView *_tableView;
    float _imageCacheSize;
    float _fileCacheSize;
    NSString *_imageCacheDirectoryPath;
    NSString *_fileCacheDirectoryPath;
}
@end

@implementation PersonViewController

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
    [_tableView reloadData];
    [[MyRequest sharedRequestBox]requestForPersonalInfoCompletion:^(bool success, People *mySelf) {
        if (success) {
            self.people=mySelf;
            [_tableView reloadData];
        }
    }];
    _imageCacheDirectoryPath=[[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ImageCache"]copy];
    _fileCacheDirectoryPath=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DownLoads"]copy];
}

/**
 *  这个方法返回单个文件的大小
 *
 *  @param filePath 文件路径
 *
 *  @return 文件大小
 */
-(long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager *manager=[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
/**
 *  返回整个文件夹里所有文件的综合
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 返回文件大小单位Mb
 */
-(float)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人中心";
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 3;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section==0) {
        cell.textLabel.text=@"个人信息";
        UIImageView *headerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(230, 3, 54, 54)];
        headerImageView.layer.cornerRadius=27;
        headerImageView.clipsToBounds=YES;
        [headerImageView setImageWithURL:[NSURL URLWithString:self.people.headerUrl] placeholderImage:[UIImage imageNamed:@"head"]];
        [cell addSubview:headerImageView];
        [headerImageView release];
        return cell;
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            _imageCacheSize=[self folderSizeAtPath:_imageCacheDirectoryPath];
            NSLog(@"folderSize=%f",_imageCacheSize);
            cell.textLabel.text=[NSString stringWithFormat:@"清空图片缓存(%.2fM)",_imageCacheSize];
            return cell;
        }
        if (indexPath.row==1) {
            _fileCacheSize=[self folderSizeAtPath:_fileCacheDirectoryPath];
            cell.textLabel.text=[NSString stringWithFormat:@"清空文件缓存(%.2fM)",_fileCacheSize];
            return cell;
        }
        cell.textLabel.text=@"退出登录";
        return cell;
    }
    cell.textLabel.text=@"关于我们";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [self viewPersonalMessage];
    }
    if (indexPath.section==1) {
        NSError *error;
        if (indexPath.row==0) {
            [[NSFileManager defaultManager]removeItemAtPath:_imageCacheDirectoryPath error:&error];
        }
        if (indexPath.row==1) {
            [[NSFileManager defaultManager]removeItemAtPath:_fileCacheDirectoryPath error:&error];
            [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"downLoadFileArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        [_tableView reloadData];
        if (indexPath.row==2) {
            [[MyRequest sharedRequestBox]requestForLoginOutCompletion:^(bool success) {
                if (success) {
                    ALERT_SHOW(@"注销登录成功");
                    //                    清空沙盒
                    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:ACCESS_TOKEN_KEY];
                    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:TIME_KEY];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    LoginViewController *loginVC=[[LoginViewController alloc]init];
                    UINavigationController *loginNav=[[UINavigationController alloc]initWithRootViewController:loginVC];
                    [UIApplication sharedApplication].delegate.window.rootViewController=loginNav;
                    [loginNav release];
                    [loginVC release];
                }
            }];
        }
    }
}
#pragma mark 查看个人信息
-(void)viewPersonalMessage
{
    PersonnalMessageViewController *personVC=[[PersonnalMessageViewController alloc]init];
    personVC.index=0;
    personVC.people=self.people;
    [self.navigationController pushViewController:personVC animated:YES];
    [personVC release];
}




@end
