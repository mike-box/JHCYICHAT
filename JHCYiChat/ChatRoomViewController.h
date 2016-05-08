//
//  ChatRoomViewController.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/1.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartChatViewController.h"
#import "PersonnalMessageViewController.h"
@interface ChatRoomViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>
@property (nonatomic,copy)NSString *access_token;
@property (nonatomic,retain)PersonnalMessageViewController *personMVC;
@property(nonatomic,retain)StartChatViewController *startChatVC;
@end
