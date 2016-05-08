//
//  StartChatViewController.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/15.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(nonatomic,retain)UIImage *headerSelf;
@property(nonatomic,retain)UIImage *headerFriend;
@property(nonatomic,copy)NSString *friendName;

@end
