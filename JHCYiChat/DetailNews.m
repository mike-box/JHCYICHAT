//
//  DetailNews.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/21.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "DetailNews.h"
#pragma mark DetailNews

@implementation DetailNews

-(id)initWithNewsDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    if (self) {
        self.commentsArray=[dictionary objectForKey:@"comments"];
        NSArray *array=[dictionary objectForKey:@"data"];
        
        NSMutableArray *resultArray=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dataDict in array) {
            Data *data=[Data dataWithDetailDictionary:dataDict];
            [resultArray addObject:data];
        }
        self.dataArray=resultArray;
        self.info=[Info infoWithDetailDictionary:[dictionary objectForKey:@"info"]];
    }
    return self;
}
+(id)detailNewsWithDictionary:(NSDictionary *)dictionary
{
    return [[[self alloc]initWithNewsDictionary:dictionary]autorelease];
}

@end

#pragma mark Data
@implementation Data

-(id)initWithDetailDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    if (self) {
        self.data_type=[[dictionary objectForKey:@"data_type"]intValue];
        if (self.data_type==2) {
            self.image=[NewsImage imagesWithDictionary:[dictionary objectForKey:@"image"]];
        }else{
            self.content=[dictionary objectForKey:@"content"];
        }
    }
    return self;
}
+(id)dataWithDetailDictionary:(NSDictionary *)dictionary
{
    return [[[self alloc]initWithDetailDictionary:dictionary]autorelease];
}


@end

#pragma mark Info
@implementation Info

-(id)initWithDetailDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    if (self) {
        self.ID=[[dictionary objectForKey:@"id"]intValue];
        self.type=[[dictionary objectForKey:@"type"]intValue];
        self.channel=[dictionary objectForKey:@"channel"];
        self.news_title=[dictionary objectForKey:@"news_title"];
        self.intro=[dictionary objectForKey:@"intro"];
        self.source_url=[dictionary objectForKey:@"source_url"];
        self.time=[dictionary objectForKey:@"time"];
        self.source=[dictionary objectForKey:@"source"];
        self.readtimes=[dictionary objectForKey:@"readtimes"];
        self.auther=[dictionary objectForKey:@"auther"];
        
        NSArray *imageUrlArray=[dictionary objectForKey:@"images"];
        NSMutableArray *resultArray=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *imageDict in imageUrlArray) {
            NewsImage *image=[NewsImage imagesWithDictionary:imageDict];
            [resultArray addObject:image];
        }
        self.imageArray=resultArray;
    }
    return self;
}
+(id)infoWithDetailDictionary:(NSDictionary *)dictionary
{
    return [[[self alloc]initWithDetailDictionary:dictionary]autorelease];
}



@end