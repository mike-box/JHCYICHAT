//
//  People.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/6.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "People.h"

@implementation People

-(id)initWithDict:(NSMutableDictionary *)dict
{
    self=[super init];
    if (self) {
        self.name=[dict objectForKey:@"name"];
        self.nickName=[dict objectForKey:@"nickname"];
        self.email=[dict objectForKey:@"email"];
        self.headerUrl=[NSString stringWithFormat:@"http://localhost:8080/st%@",[dict objectForKey:@"headerurl"]];
    }
    return self;
}


+(id)peopleWithDict:(NSMutableDictionary *)dict
{
    return [[[self alloc]initWithDict:dict]autorelease];
}

@end
