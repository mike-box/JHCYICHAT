//
//  News.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/21.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "News.h"

@implementation News

-(id)initWithNewsDictionary:(NSDictionary *)dict
{
    self=[super init];
    if (self) {
        self.ID=[[dict objectForKey:@"id"]intValue];
        self.type=[[dict objectForKey:@"type"]intValue];
        self.channel=[dict objectForKey:@"channel"];
        self.news_title=[dict objectForKey:@"news_title"];
        self.intro=[dict objectForKey:@"intro"];
        self.source_url=[dict objectForKey:@"source_url"];
        self.time=[dict objectForKey:@"time"];
        self.source=[dict objectForKey:@"source"];
        self.readtimes=[dict objectForKey:@"readtimes"];
        self.auther=[dict objectForKey:@"auther"];
        
        if (self.type==6) {
            NSMutableArray *tempArray=[NSMutableArray arrayWithCapacity:0];
            NSArray *imageArray=[dict objectForKey:@"images"];
            for (NSDictionary *imageDict in imageArray) {
                NewsImage *image=[NewsImage imagesWithDictionary:imageDict];
                [tempArray addObject:image];
            }
            self.imageArray=tempArray;
        }
        self.image=[NewsImage imagesWithDictionary:[[dict objectForKey:@"images"] objectAtIndex:0]];
        
    }
    return self;
}
+(id)newsWithDictionary:(NSDictionary *)dict
{
    return [[[self alloc]initWithNewsDictionary:dict]autorelease];
}


- (void)dealloc
{
    [_channel release];
    [_news_title release];
    [_intro release];
    [_source_url release];
    [_time release];
    [_source release];
    [_readtimes release];
    [_auther release];
    [_image release];
    [_imageArray release];
    [super dealloc];
}

@end


@implementation NewsImage

-(id)initWithImagesDictionary:(NSDictionary *)dict
{
    self=[super init];
    if (self) {
        self.url=[NSString stringWithFormat:@"http://localhost:8080%@",[dict objectForKey:@"url"]];
        self.source_url=[NSString stringWithFormat:@"http://localhost:8080%@",[dict objectForKey:@"source"]];
        self.size=CGSizeMake([[dict objectForKey:@"width"]floatValue], [[dict objectForKey:@"height"]floatValue]);
        
    }
    return self;
}

+(id)imagesWithDictionary:(NSDictionary *)dict
{
    return [[[self alloc]initWithImagesDictionary:dict]autorelease];
}

- (void)dealloc
{
    [_url release];
    [super dealloc];
}

@end


