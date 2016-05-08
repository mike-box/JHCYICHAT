//
//  PictureNewsTableViewCell.h
//  课件YiChat
//
//  Created by 九条さくらこ on 16/4/21.
//  Copyright (c) 2016年 Celestial Being. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureNewsTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *newsTitle;
@property (retain, nonatomic) IBOutlet UIButton *sourceBtn;
@property (retain, nonatomic) IBOutletCollection(UIImageView) NSArray *newsImage;



@end
