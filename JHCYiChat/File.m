//
//  File.m
//  JHCYiChat
//
//  Created by 九条桜子 on 16/4/23.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "File.h"

@implementation File

-(id)initWithFileDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    if (self) {
        self.ID=[dictionary objectForKey:@"id"];
        self.type=[[dictionary objectForKey:@"type"]intValue];
        self.mimetype=[dictionary objectForKey:@"mimetype"];
        NSDictionary *imageSizeDict=[dictionary objectForKey:@"image"];
        self.imageSize=CGSizeMake([[imageSizeDict objectForKey:@"width"]intValue], [[imageSizeDict objectForKey:@"height"]intValue]) ;
        self.image_url=[dictionary objectForKey:@"image_url"];
        self.url=[dictionary objectForKey:@"url"];
        self.name=[dictionary objectForKey:@"name"];
        self._description=[dictionary objectForKey:@"description"];
        self.author=[dictionary objectForKey:@"author"];
        self.tname=[dictionary objectForKey:@"tname"];
        self.time=[dictionary objectForKey:@"time"];
        self.dtimes=[dictionary objectForKey:@"dtimes"];
        self.length=[[dictionary objectForKey:@"length"]longLongValue];
    }
    return self;
}
+(id)fileWithDictionary:(NSDictionary *)dictionary
{
    return [[[self alloc]initWithFileDictionary:dictionary]autorelease];;
}

#pragma mark - NSCoding协议方法
/**
 *  编码
 *
 *  @param aCoder NSCoder*
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.ID forKey:@"id"];
    [aCoder encodeInt:self.type forKey:@"type"];
    [aCoder encodeCGSize:self.imageSize forKey:@"imageSize"];
    [aCoder encodeObject:self.localPath forKey:@"localPath"];
    [aCoder encodeObject:self.mimetype forKey:@"mimetype"];
    [aCoder encodeObject:self.image_url forKey:@"image_url"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.tname forKey:@"tname"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.dtimes forKey:@"dtime"];
    [aCoder encodeObject:self._description forKey:@"_description"];
    [aCoder encodeInteger:(int)self.length forKey:@"length"];
}
/**
 *  解码
 *
 *  @param aDecoder NSCoder
 *
 *  @return File*
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.ID = [aDecoder decodeObjectForKey:@"id"];
        self.type=[aDecoder decodeIntForKey:@"type"];
        self.localPath=[aDecoder decodeObjectForKey:@"localPath"];
        self.imageSize=[aDecoder decodeCGSizeForKey:@"imageSize"];
        self.mimetype=[aDecoder decodeObjectForKey:@"mimetype"];
        self.image_url=[aDecoder decodeObjectForKey:@"image_url"];
        self.url=[aDecoder decodeObjectForKey:@"url"];
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.author=[aDecoder decodeObjectForKey:@"author"];
        self.tname=[aDecoder decodeObjectForKey:@"tname"];
        self.time=[aDecoder decodeObjectForKey:@"time"];
        self.dtimes=[aDecoder decodeObjectForKey:@"dtime"];
        self._description=[aDecoder decodeObjectForKey:@"_description"];
        self.length=(long long)[aDecoder decodeIntForKey:@"length"];
    }
    return self;
}

@end
