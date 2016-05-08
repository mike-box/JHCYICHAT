//
//  ChatRoomViewController.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/1.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "ChatRoomViewController.h"




@interface ChatRoomViewController ()
{
    UITableView *_tableView;
    NSMutableData *_data;
    NSArray *_dataArray;
    NSArray *_headArray;
    
}
@end

@implementation ChatRoomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.personMVC=[[[PersonnalMessageViewController alloc]init]autorelease];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    //    请求好友列表
    [[MyRequest sharedRequestBox]friendListRequestWithcompletion:^(NSMutableArray *resultArray, bool success) {
        if (success) {
            _dataArray=resultArray;
            [_tableView reloadData];
        }
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _data=[[NSMutableData alloc]initWithCapacity:0];
    self.title=@"聊天中心";
    
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _tableView.rowHeight=75.0;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    
}


#pragma mark tableView设置

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    People *p=_dataArray[indexPath.row];
    cell.nameLabel.text=p.nickName;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.messageNumLabel.hidden=NO;
    if (indexPath.row==0) {
        cell.messageNumLabel.hidden=YES;
    }
    [cell.headerImage setBackgroundImageWithURL:[NSURL URLWithString:p.headerUrl] placeholderImage:[UIImage imageNamed:@"head"]];
    
    cell.headerImage.tag=indexPath.row;
    [cell.headerImage addTarget:self action:@selector(viewPersonalMessage:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark 查看个人信息
-(void)viewPersonalMessage:(UIButton *)sender
{
    PersonnalMessageViewController *personVC=[[PersonnalMessageViewController alloc]init];
    People *p=_dataArray[sender.tag];
    personVC.index=sender.tag;
    personVC.people=p;
    
    
    [self.navigationController pushViewController:personVC animated:YES];
    [personVC release];
}

#pragma mark 选中单元格的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return;
    }
    StartChatViewController *startChatVC=[[[StartChatViewController alloc]init]autorelease];
    [self.navigationController pushViewController:startChatVC animated:YES];
    startChatVC.headerSelf=((TableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).headerImage.currentBackgroundImage;
    startChatVC.headerFriend=((TableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]).headerImage.currentBackgroundImage;
    startChatVC.friendName=((People*)_dataArray[indexPath.row]).name;
}


- (void)dealloc
{
    [_tableView release];
    [_dataArray release];
    [_data release];
    [_personMVC release];
    [_startChatVC release];
    [_access_token release];
    [super dealloc];
}


@end
