//
//  News.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/21.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsImage;


@interface News : NSObject
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
@property(nonatomic,retain)NewsImage *image;
@property(nonatomic,retain)NSMutableArray*imageArray;



-(id)initWithNewsDictionary:(NSDictionary *)dict;
+(id)newsWithDictionary:(NSDictionary *)dict;
@end

@interface NewsImage : NSObject

@property(nonatomic,assign)CGSize size;
@property(nonatomic,copy)NSString  *url;
@property(nonatomic,copy)NSString *source_url;



-(id)initWithImagesDictionary:(NSDictionary *)dict;
+(id)imagesWithDictionary:(NSDictionary *)dict;


@end


