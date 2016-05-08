//
//  MyRequest.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/5.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
@interface MyRequest : NSObject<ASIHTTPRequestDelegate>
@property(nonatomic,retain)NSMutableDictionary *friendListDict;
@property(nonatomic,retain)NSMutableArray *allHeader;

/**
 *  返回MyRequest对象 单例类
 *
 *  @return 单例
 */
+(id)sharedRequestBox;
/**
 *  登录请求
 *
 *  @param userName   用户名
 *  @param password   密码
 *  @param completion 请求完成后的操作
 */
-(void)loginRequest:(NSString *)userName withPassword:(NSString *)password completion:(void(^)(bool success,NSDictionary *resultDic))completion;
/**
 *  注册请求
 *
 *  @param name       用户名
 *  @param password   密码
 *  @param nickName   昵称
 *  @param email      邮箱
 *  @param completion 请求完成后的操作
 */
-(void)registerRequest:(NSString *)name password:(NSString *)password nickName:(NSString *)nickName email:(NSString *)email completion:(void(^)(bool success))completion;
/**
 *  请求好友列表
 *
 *  @param completion 请求完成后的操作
 */
-(void)friendListRequestWithcompletion:(void(^)(NSMutableArray *resultArray,bool success))completion;
/**
 *  上传头像请求
 *
 *  @param headerData 头像数据
 *  @param completion 请求完成后的操作
 */
-(void)uploadHeaderRequestHeaderData:(NSData *)headerData completion:(void(^)(bool success))completion;
/**
 *  请求个人信息
 *
 *  @param completion 请求完成后的操作
 */
-(void)requestForPersonalInfoCompletion:(void(^)(bool success,People *mySelf))completion;
/**
 *  修改个人信息接口
 *
 *  @param nickName   neighbor
 *  @param email      邮箱
 *  @param completion 请求完成后的操作
 */
-(void)updatePersonalMessageWithNickName:(NSString *)nickName email:(NSString *)email completion:(void(^)(bool success))completion;
/**
 *  发送消息接口
 *
 *  @param friendName 好友账号
 *  @param chatInfo   聊天内容
 *  @param completion 请求完成后的操作
 */
-(void)requestForSendMessageWithfriendName:(NSString *)friendName chatInfo:(NSString *)chatInfo completion:(void(^)(BOOL success))completion;
/**
 *  获取聊天列表接口
 *
 *  @param completion 请求完成后的操作
 */
-(void)requestForChatListCompletion:(void(^)(NSArray *resultArray))completion;
/**
 *  请求新闻列表
 *
 *  @param completion 请求完成后的操作
 */
-(void)requestForNewsListCompletion:(void(^)(NSArray *newsResultArray))completion;
/**
 *  请求新闻详情接口
 *
 *  @param source_url 接口url
 *  @param completion 请求完成后的操作
 */
-(void)requestForDetailNews:(NSString *)source_url completion:(void(^)(DetailNews *detailNews))completion;
/**
 *  注销登录接口
 *
 *  @param completion 请求完成后的操作
 */
-(void)requestForLoginOutCompletion:(void(^)(bool success))completion;
/**
 *  文件列表接口
 *
 *  @param completion 请求完成后的操作
 */
-(void)requestForFileListCompletion:(void(^)(bool success,NSMutableArray *pubFileArray,NSMutableArray *perFileArray))completion;

/**
 *  下载文件
 *
 *  @param dePath     目标路径
 *  @param tempPath   缓存路径
 *  @param file       文件对象
 *  @param cell       文件所在的单元格
 *  @param completion 下载完成后的操作
 */
-(void)downloadFileRequestWithDePath:(NSString *)dePath tempPath:(NSString *)tempPath file:(File *)file progressCell:(UICollectionViewCell *)cell completion:(void(^)(bool success,NSData*fileData))completion;

/**
 *  判断是否需要登录
 *
 *  @return YES:需要登录 NO:不需要登录 直接跳转 
 */
-(BOOL)isNeedLogin;

@end
