//
//  DetailTableViewController.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/22.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "DetailTableViewController.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[MyRequest sharedRequestBox]requestForDetailNews:self.source_url completion:^(DetailNews *detailNews) {
        self.detailNews=detailNews;
        [self.tableView reloadData];
    }];
    
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)return 2;
    if (section==1)return self.detailNews.dataArray.count;
    return self.detailNews.commentsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    标题
    if (indexPath.section==0) {
        if (indexPath.row==1)return [self.detailNews.info.intro boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil].size.height+10;
        return 80;
    }
    //    新闻数据
    if (indexPath.section==1) {
        Data *data=[self.detailNews.dataArray objectAtIndex:indexPath.row];
        
        if (data.data_type==2) return data.image.size.height+10;
        return [data.content boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil].size.height+10;
    }
    //    评论
    if (indexPath.row==0) return 44;
    
    NSDictionary *commentDict=[self.detailNews.commentsArray objectAtIndex:indexPath.row];
    NSString *commentString=[NSString stringWithFormat:@"%@ \n%@",[commentDict objectForKey:@"name"],[commentDict objectForKey:@"info"]];
    return [commentString boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil].size.height+10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"]autorelease];
    }
    
    //    清楚重用单元格的内容和设置
    UIView *view=[cell viewWithTag:1];
    [view removeFromSuperview];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.backgroundColor=[UIColor whiteColor];
    [view removeFromSuperview];
    cell.textLabel.text=@"";
    cell.detailTextLabel.text=@"";
    
    
    //    新闻标题
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.font=[UIFont boldSystemFontOfSize:15];
            cell.textLabel.textAlignment=NSTextAlignmentJustified;
            cell.textLabel.text=self.detailNews.info.news_title;
            NSString *string=[NSString stringWithFormat:@"%@ \t%@/文 \t %@",self.detailNews.info.source,self.detailNews.info.auther,self.detailNews.info.time];
            cell.detailTextLabel.text=string;
            return cell;
        }
        if (indexPath.row==1) {
            NSString *string=[NSString stringWithFormat:@"摘要: %@",self.detailNews.info.intro];
            cell.textLabel.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            cell.textLabel.numberOfLines=0;
            cell.textLabel.font=[UIFont systemFontOfSize:13];
            cell.textLabel.text=string;
            return cell;
        }
    }
    
    if (indexPath.section==1) {
        Data *data=[self.detailNews.dataArray objectAtIndex:indexPath.row];
        if (data.data_type==2) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, data.image.size.height)];
            NSLog(@"%@----------",data.image.source_url);
            [imageView setImageWithURL:[NSURL URLWithString:data.image.source_url]];
            imageView.tag=1;
            [cell addSubview:imageView];
            [imageView release];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines=0;
        cell.textLabel.text=data.content;
        return cell;
    }
    
    //    评论
    if (indexPath.row==0) {
        cell.textLabel.font=[UIFont boldSystemFontOfSize:18];
        cell.textLabel.text=@"热门跟帖";
        return cell;
    }
    
    NSDictionary *commentDict=[self.detailNews.commentsArray objectAtIndex:indexPath.row-1];
    cell.textLabel.textColor=[UIColor purpleColor];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:15];
    cell.detailTextLabel.numberOfLines=0;
    cell.textLabel.text=[commentDict objectForKey:@"name"];
    cell.detailTextLabel.text=[commentDict objectForKey:@"info"];
    return cell;
}




@end
