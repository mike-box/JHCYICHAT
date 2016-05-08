//
//  MyRequest.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/5.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "MyRequest.h"
static MyRequest *myRueuestBox;
@implementation MyRequest



+(id)sharedRequestBox
{
    @synchronized(self) {
        if (myRueuestBox==nil) {
            myRueuestBox=[[super allocWithZone:NULL]init];
            myRueuestBox.friendListDict=[NSMutableDictionary dictionary];
            myRueuestBox.allHeader=[NSMutableArray array];
        }
    }
    return myRueuestBox;
}



#pragma mark 登录请求
-(void)loginRequest:(NSString *)userName withPassword:(NSString *)password completion:(void(^)(bool success,NSDictionary *resultDic))completion
{
    NSString *urlString=HOST(@"ST_L");
    NSURL *url=[NSURL URLWithString:urlString];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:userName forKey:@"name"];
    [request setPostValue:password forKey:@"psw"];
    
    [request setCompletionBlock:^{
        NSDictionary *resultDic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString *error=[resultDic objectForKey:@"error"];
        if (error) {
            ALERT_SHOW(error);
        }else
        {
            if (completion) {
                completion(YES,resultDic);
            }
        }
    }];
    [request startAsynchronous];
    
}
#pragma mark 注册请求
-(void)registerRequest:(NSString *)name password:(NSString *)password nickName:(NSString *)nickName email:(NSString *)email completion:(void(^)(bool success))completion
{
    NSString *urlString=HOST(@"ST_R");
    NSURL *url=[NSURL URLWithString:urlString];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:name forKey:@"name"];
    [request setPostValue:password forKey:@"psw"];
    [request setPostValue:nickName forKey:@"nickname"];
    [request setPostValue:email forKey:@"email"];
    
    RequestCompletionNoArgument
    [request startAsynchronous];
}
#pragma mark 请求好友列表
-(void)friendListRequestWithcompletion:(void(^)(NSMutableArray *resultArray,bool success))completion
{
    
    NSMutableArray *peopleArray=[NSMutableArray arrayWithCapacity:0];
    
    NSString *urlString=HOST_ACCESS_TOKEN(@"ST_FL",ACCESS_TOKEN_VALUE);
    NSURL *url=[NSURL URLWithString:urlString];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        NSMutableDictionary *resultDict=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString *error=[resultDict objectForKey:@"error"];
        
        if (error) {
            ALERT_SHOW(error);
        }else{
            NSMutableArray *dataArray=[[resultDict objectForKey:@"data"]retain];
            for (NSMutableDictionary *smallDict in dataArray) {
                People *p=[[People alloc]initWithDict:smallDict];
                [peopleArray addObject:p];
                [p release];
            }
            [dataArray release];
            if (completion) {
                completion(peopleArray,YES);
            }
        }
    }];
    [request startAsynchronous];
}

#pragma mark 请求上传头像
-(void)uploadHeaderRequestHeaderData:(NSData *)headerData completion:(void(^)(bool success))completion
{
    NSString *urlString=HOST_ACCESS_TOKEN(@"ST_H", ACCESS_TOKEN_VALUE);
    NSURL *url=[NSURL URLWithString:urlString];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    NSMutableData *data=[NSMutableData dataWithData:headerData];
    request.postBody=data;
    
    RequestCompletionNoArgument
    [request startAsynchronous];
    
}
#pragma mark 获取个人信息
-(void)requestForPersonalInfoCompletion:(void(^)(bool success,People *mySelf))completion
{
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:HOST_ACCESS_TOKEN(@"ST_GPI", ACCESS_TOKEN_VALUE)]];
    [request setCompletionBlock:^{
        NSDictionary *resultDict=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        People *p=[People peopleWithDict:[resultDict objectForKey:@"data"]];
        if (completion) {
            completion(YES,p);
        }
    }];
    [request startAsynchronous];
}

#pragma mark 修改个人信息
-(void)updatePersonalMessageWithNickName:(NSString *)nickName email:(NSString *)email completion:(void(^)(bool success))completion
{
    NSString *urlString=HOST_ACCESS_TOKEN(@"ST_SPI",ACCESS_TOKEN_VALUE);
    NSURL *url=[NSURL URLWithString:urlString];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:nickName forKey:@"nickname"];
    [request setPostValue:email forKey:@"email"];
    
    RequestCompletionNoArgument
    [request startAsynchronous];
}

#pragma mark 发送聊天请求

-(void)requestForSendMessageWithfriendName:(NSString *)friendName chatInfo:(NSString *)chatInfo completion:(void(^)(BOOL success))completion
{
    NSString *urlString=HOST_ACCESS_TOKEN(@"ST_CS",ACCESS_TOKEN_VALUE);
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setPostValue:friendName forKey:@"friendname"];
    [request setPostValue:chatInfo forKey:@"chatinfo"];
    
    RequestCompletionNoArgument
    [request startAsynchronous];
}
#pragma mark 读取聊天列表接口
-(void)requestForChatListCompletion:(void(^)(NSArray *resultArray))completion
{
    NSString *urlString=HOST_ACCESS_TOKEN(@"ST_CG",ACCESS_TOKEN_VALUE);
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setCompletionBlock:^{
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        NSArray *dataArray=[dict objectForKey:@"data"];
        if (completion) {
            completion(dataArray);
        }
    }];
    [request startAsynchronous];
}
#pragma mark 请求新闻列表接口
-(void)requestForNewsListCompletion:(void(^)(NSArray *newsResultArray))completion
{
    __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",@"/st/news/news_list2.json"]]];
    [request setCompletionBlock:^{
        NSMutableDictionary *resultDict=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString *error=[resultDict objectForKey:@"error"];
        if (error) {
            ALERT_SHOW(error);
        }else{
            NSMutableArray *newsArray=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *resultArray=[resultDict objectForKey:@"news_list"];
            for (NSDictionary *newsList in resultArray) {
                News *news=[News newsWithDictionary:newsList];
                [newsArray addObject:news];
            }
            if (completion) {
                completion(newsArray);
            }
        }
    }];
    [request startAsynchronous];
}
#pragma 请求具体新闻
-(void)requestForDetailNews:(NSString *)source_url completion:(void(^)(DetailNews *detailNews))completion
{
    __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",source_url]]];
    [request setCompletionBlock:^{
        NSDictionary *resultDic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        
        DetailNews *resutlDetailNews=[DetailNews detailNewsWithDictionary:resultDic];
        
        if (completion) {
            completion(resutlDetailNews);
        }
    }];
    [request startAsynchronous];
}
#pragma mark 注销登录
-(void)requestForLoginOutCompletion:(void(^)(bool success))completion
{
    __block ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:HOST_ACCESS_TOKEN(@"ST_LO", ACCESS_TOKEN_VALUE)]];
    RequestCompletionNoArgument
    [request startAsynchronous];
    
}

#pragma mark 请求文件列表
-(void)requestForFileListCompletion:(void(^)(bool success,NSMutableArray *pubFileArray,NSMutableArray *perFileArray))completion
{
    __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:HOST_ACCESS_TOKEN(@"ST_F_FL", ACCESS_TOKEN_VALUE)]];
    NSLog(@"%@",HOST_ACCESS_TOKEN(@"ST_F_FL", ACCESS_TOKEN_VALUE));
    [request setCompletionBlock:^{
        NSDictionary *resultDic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString *error=[resultDic objectForKey:@"error"];
        
        if (error) {
            ALERT_SHOW(error);
        }else{
            NSDictionary *fileList=[resultDic objectForKey:@"filelist"];
            NSArray *fileArray1=[fileList objectForKey:@"pub_file"];
            NSArray *fileArray2=[fileList objectForKey:@"per_file"];
            NSMutableArray *resultFileArray1=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *resultFileArray2=[NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *fileDict in fileArray1) {
                File *file=[File fileWithDictionary:fileDict];
                [resultFileArray1 addObject:file];
            }
            
            for (NSDictionary *fileDict in fileArray2) {
                File *file=[File fileWithDictionary:fileDict];
                [resultFileArray2 addObject:file];
            }
            
            if (completion) {
                completion(YES,resultFileArray1,resultFileArray2);
            }
        }
    }];
    [request startAsynchronous];
    
}

#pragma mark - 下载文件请求
-(void)downloadFileRequestWithDePath:(NSString *)dePath tempPath:(NSString *)tempPath file:(File *)file progressCell:(UICollectionViewCell *)cell completion:(void(^)(bool success,NSData*fileData))completion
{
    //    发送请求
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:file.url]];
    //    设置目的路径
    request.downloadDestinationPath=dePath;
    //    设置临时路径
    request.temporaryFileDownloadPath=tempPath;
    //    允许断点下载
    request.allowResumeForFileDownloads=YES;
    //    设置进度条
    UIProgressView *progress=(UIProgressView *)[cell viewWithTag:4];
    request.downloadProgressDelegate=progress;
    //    下载完成后执行的操作
    [request setCompletionBlock:^{
        ((UILabel *)[cell viewWithTag:3]).text=@"查看";
        //        下载完成后移除进度条
        [progress removeFromSuperview];
        file.localPath=dePath;
        NSData *fileData=[NSKeyedArchiver archivedDataWithRootObject:file];
        //        往已下载文件数组中添加文件 要先转换成data格式 之后需要存储到本地
        if (completion) {
            completion(YES,fileData);
        }
    }];
    [request startAsynchronous];
}



#pragma mark 是否需要重新登录
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
