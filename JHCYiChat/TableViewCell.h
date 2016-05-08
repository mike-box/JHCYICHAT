//
//  TableViewCell.h
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/2.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell


@property(retain,nonatomic)UIButton *headerImage;
@property(retain,nonatomic)UILabel *nameLabel;
@property(retain,nonatomic)UILabel *messageLabel;
@property(retain,nonatomic)UILabel *messageNumLabel;



@end
