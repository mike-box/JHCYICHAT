//
//  StartChatViewController.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/15.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "StartChatViewController.h"

@interface StartChatViewController ()

{
    //    键盘实现后控制电机事件让键盘隐藏
    UIControl *_control;
    UIView *_textView;
    UITextField *_textField;
    NSMutableArray *_chatInfoArray;
    UITableView *_tableView;
    NSTimer *_timer;
}
@end

@implementation StartChatViewController

-(void)viewWillAppear:(BOOL)animated
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(requestChatMessage) userInfo:nil repeats:YES];
    
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_timer invalidate];
}
-(void)requestChatMessage
{
    [[MyRequest sharedRequestBox]requestForChatListCompletion:^(NSArray *resultArray) {
        for (NSDictionary *chatInfoDict in resultArray) {
            NSString *chatInfo=[chatInfoDict objectForKey:self.friendName];
            [self reloadTableViewWithChatInfo:chatInfo isMyself:NO];
        }
    }];
    [_tableView reloadData];
}

#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    _chatInfoArray=[[NSMutableArray alloc]initWithCapacity:0];
    _tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    [self addSendMessageUI];
    //    创建点击事件，但不添加到view
    _control=[[UIControl alloc]initWithFrame:self.view.frame];
    [_control addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardUp:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDown:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
}

#pragma mark 隐藏键盘的方法
-(void)endEditing
{
    [self.view endEditing:YES];
}


#pragma mark 键盘将要显示
-(void)keyboardUp:(NSNotification *)notification
{
    //    添加隐藏键盘的隐藏事件
    [self.view addSubview:_control];
    NSDictionary *infoDict=[notification userInfo];
    CGSize keyBoardSize=[[infoDict objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    
    _textView.frame=CGRectMake(0, SCREEN_HEIGHT-keyBoardSize.height-44, 320, 44);
    _tableView.frame=CGRectMake(0, -keyBoardSize.height, 320, SCREEN_HEIGHT-44);
    
    [UIView commitAnimations];
    
    
    
}

#pragma mark 键盘将要隐藏
-(void)keyboardDown:(NSNotification *)notification
{
    //    将隐藏键盘的点击事件移除掉
    [_control removeFromSuperview];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    
    _textView.frame=CGRectMake(0, SCREEN_HEIGHT-44, 320, 44);
    _tableView.frame=CGRectMake(0, 0, 320, SCREEN_HEIGHT-44);
    
    [UIView commitAnimations];
    
    
}

#pragma mark 创建发送信息的view
-(void)addSendMessageUI
{
    _textView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44, 320, 44)];
    [self.view addSubview:_textView];
    //    创建背景图片
    UIImageView *bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    bgImage.image=[UIImage imageNamed:@"chatinputbg"];
    [_textView addSubview:bgImage];
    [bgImage release];
    //    创建UITextField
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(15, 7, 220, 30)];
    _textField.borderStyle=UITextBorderStyleRoundedRect;
    _textField.delegate=self;
    [_textView addSubview:_textField];
    //    创建按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(250, 7, 40, 30);
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sendChatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_textView addSubview:btn];
}
#pragma mark 点击发送键的方法
-(void)sendChatBtnClick:(UIButton *)sender
{
    if ([_textField.text isEqualToString:@""]) {
        return;
    }
    //    拼接消息
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM月dd日HH:mm:ss"];
    NSString *dataString=[formatter stringFromDate:[NSDate date]];
    
    [formatter release];
    //    用base64加密消息和时间
    NSString *chatInfo=[[NSString stringWithFormat:@"在%@说: %@",dataString,_textField.text] base64EncodedString];
    
    //    发送请求
    [[MyRequest sharedRequestBox]requestForSendMessageWithfriendName:self.friendName chatInfo:chatInfo completion:^(BOOL success) {
        if (success) {
            //            刷新表的内容
            [self reloadTableViewWithChatInfo:chatInfo isMyself:YES];
        }
    }];
    
}
#pragma mark 根据聊天内容刷新表
-(void)reloadTableViewWithChatInfo:(NSString *)chatInfo isMyself:(BOOL)isMyself
{
    chatInfo=[chatInfo base64DecodedString];
    //    根据字符串聊天内容 创建气泡 把气泡当成view 放进chatArray
    UIView *chatView=[self createBubbleView:chatInfo isMyself:isMyself];
    
    //    把chatView作为数据源放入数据源数组
    [_chatInfoArray addObject:chatView];
    
    //    数据源改变 刷新表 并清空输入框
    [_tableView reloadData];
    _textField.text=@"";
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_chatInfoArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark 创建气泡
-(UIView *)createBubbleView:(NSString *)chatInfo isMyself:(BOOL)isMyself
{
    //    定宽求高度
    CGSize size=[chatInfo boundingRectWithSize:CGSizeMake(190, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil].size;
    
    //    好友头像或自己头像
    UIImageView *header=[[UIImageView alloc]initWithFrame:CGRectMake(isMyself?280-55:5, 15, 40, 40)];
    header.image=isMyself?self.headerSelf:self.headerFriend;
    header.layer.cornerRadius=20;
    header.clipsToBounds=YES;
    
    //    label显示聊天内容
    UILabel *chatLabel=[[UILabel alloc]initWithFrame:CGRectMake(isMyself?16:70, 15, 190, size.height+10)];
    chatLabel.numberOfLines=0;
    chatLabel.font=[UIFont systemFontOfSize:17.0];
    chatLabel.backgroundColor=[UIColor clearColor];
    chatLabel.text=chatInfo;
    
    //    创建气泡背景图
    UIImageView *bgBubble=[[UIImageView alloc]initWithFrame:CGRectMake(isMyself?5:50, 10, 210, size.height+20)];
    UIImage *oldImage=[UIImage imageNamed:isMyself?@"bubbleSelf":@"bubble"];
    UIImage *newImage=[oldImage stretchableImageWithLeftCapWidth:25 topCapHeight:20];
    bgBubble.image=newImage;
    
    //    创建气泡view
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(isMyself?50:0, 0, 220, size.height+20)];
    [view addSubview:header];
    view.tag=100;  //防止重用
    [view addSubview:bgBubble];
    [view addSubview:chatLabel];
    [header release];
    [bgBubble release];
    [chatLabel release];
    return [view autorelease];
}



#pragma mark 点击return键的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_textField.text isEqualToString:@""]) {
        return NO;
    }
    //    拼接消息
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM月dd日HH:mm:ss"];
    NSString *dataString=[formatter stringFromDate:[NSDate date]];
    [formatter release];
    //    用base64加密消息和时间
    NSString *chatInfo=[[NSString stringWithFormat:@"在%@说: %@",dataString,_textField.text] base64EncodedString];
    
    //    发送请求
    [[MyRequest sharedRequestBox]requestForSendMessageWithfriendName:self.friendName chatInfo:chatInfo completion:^(BOOL success) {
        if (success) {
            //            刷新表的内容
            [self reloadTableViewWithChatInfo:chatInfo isMyself:YES];
        }
    }];
    
    return YES;
    
}

#pragma mark 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIView *view=[_chatInfoArray objectAtIndex:indexPath.row];
    return view.frame.size.height+20;
    
    
    
}
#pragma mark 设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _chatInfoArray.count;
}
#pragma mark 设置单元格
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"]autorelease];
    }
    UIView *view=(UIView*)[cell viewWithTag:100];
    NSLog(@"0----%d",view.retainCount);
    [view removeFromSuperview];
    NSLog(@"1-----%d",view.retainCount);
    view=[_chatInfoArray objectAtIndex:indexPath.row];
    NSLog(@"2-----%d",view.retainCount);
    [cell addSubview:view];
    
    
    return cell;
}


//





- (void)dealloc
{
    [_textView release];
    [_textField release];
    [_control release];;
    [_chatInfoArray release];
    [_tableView release];
    [_timer invalidate];
    [super dealloc];
}








@end
