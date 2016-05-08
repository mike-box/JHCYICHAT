//
//  NewsViewController.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/1.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "NewsViewController.h"
#import "TextNewsTableViewCell.h"
#import "PictureNewsTableViewCell.h"
#import "DetailTableViewController.h"
@interface NewsViewController ()
{
    UITableView *_tableView;
}
@end

@implementation NewsViewController

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
    [[MyRequest sharedRequestBox]requestForNewsListCompletion:^(NSArray *newsResultArray) {
        self.newsArray=newsResultArray;
        [_tableView reloadData];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"新闻";
    _tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    //    注册单元格
    [_tableView registerNib:[UINib nibWithNibName:@"TextNewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"textCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"PictureNewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"pictureCell"];
}

#pragma mark 设置表的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsArray.count;
}
#pragma mark 设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *news=[self.newsArray objectAtIndex:indexPath.row];
    if (news.type==6)return 105;
    
    return 90;
}
#pragma mark 设置单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *news=[self.newsArray objectAtIndex:indexPath.row];
    //    文字新闻
    if (news.type!=6) {
        TextNewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
        [cell.newsimage setImageWithURL:[NSURL URLWithString:news.image.url]];
        cell.newsTitle.text=news.news_title;
        cell.newsContent.text=news.intro;
        [cell.newsSourceBtn setTitle:news.source forState:UIControlStateNormal];
        return cell;
    }
    //    图片新闻
    PictureNewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"pictureCell"forIndexPath:indexPath];
    for (int i=0; i<3; i++) {
        [[cell.newsImage objectAtIndex:i] setImageWithURL:[NSURL URLWithString:((NewsImage *)[news.imageArray objectAtIndex:i]).url]];
    }
    cell.newsTitle.text=news.news_title;
    [cell.sourceBtn setTitle:news.source forState:UIControlStateNormal];
    return cell;
}
#pragma mark 点击单元格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewController *detailVC=[[DetailTableViewController alloc]init];
    detailVC.source_url=((News *)[_newsArray objectAtIndex:indexPath.row]).source_url;
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}



- (void)dealloc
{
    [_tableView release];
    [_newsArray release];
    [super dealloc];
}



@end
