//
//  People.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/6.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject

@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *password;
@property(copy,nonatomic)NSString *nickName;
@property(copy,nonatomic)NSString *email;
@property(copy,nonatomic)NSString *headerUrl;
@property(copy,nonatomic)NSString *chatInfo;



-(id)initWithDict:(NSMutableDictionary *)dict;


+(id)peopleWithDict:(NSMutableDictionary *)dict;


@end
