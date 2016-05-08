//
//  DetailTableViewController.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/22.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewController : UITableViewController

@property (nonatomic,copy)NSString *source_url;
@property (nonatomic,retain)DetailNews *detailNews;

@end
