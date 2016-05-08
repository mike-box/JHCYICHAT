//
//  File.h
//  JHCYiChat
//
//  Created by 九条桜子 on 16/4/23.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File : NSObject<NSCoding>

@property(nonatomic,copy) NSString *ID;
@property(nonatomic,assign) int type;
@property(nonatomic,copy) NSString *mimetype;
@property(nonatomic,assign) CGSize imageSize;
@property(nonatomic,copy) NSString *image_url;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *_description;
@property(nonatomic,copy) NSString *author;
@property(nonatomic,copy) NSString *tname;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *dtimes;
@property(nonatomic,copy) NSString *localPath;
@property(nonatomic,assign) long long length;




-(id)initWithFileDictionary:(NSDictionary *)dictionary;
+(id)fileWithDictionary:(NSDictionary *)dictionary;





@end
