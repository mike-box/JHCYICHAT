//
//  DetailNews.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/21.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Data;
@class Info;
#pragma mark DetailNews
@interface DetailNews : NSObject

@property(nonatomic,retain)NSArray *commentsArray;
@property(nonatomic,retain)NSArray *dataArray;
@property(nonatomic,retain)Info *info;
-(id)initWithNewsDictionary:(NSDictionary *)dictionary;
+(id)detailNewsWithDictionary:(NSDictionary *)dictionary;

@end

#pragma mark Data
@interface Data : NSObject

@property(nonatomic,assign)int data_type;
@property(nonatomic,retain)NewsImage *image;
@property(nonatomic,copy)NSString *content;
-(id)initWithDetailDictionary:(NSDictionary *)dictionary;
+(id)dataWithDetailDictionary:(NSDictionary *)dictionary;
@end


#pragma mark Info
@interface Info : NSObject

@property(nonatomic,assign)int ID;
@property(nonatomic,assign)int type;
@property(nonatomic,copy)NSString *channel;
@property(nonatomic,copy)NSString *news_title;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *source_url;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSString *readtimes;
@property(nonatomic,copy)NSString *auther;
@property(nonatomic,retain)NSArray *imageArray;

-(id)initWithDetailDictionary:(NSDictionary *)dictionary;
+(id)infoWithDetailDictionary:(NSDictionary *)dictionary;
@end








