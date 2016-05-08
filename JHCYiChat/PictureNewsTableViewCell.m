//
//  PictureNewsTableViewCell.m
//  课件YiChat
//
//  Created by 九条さくらこ on 16/4/21.
//  Copyright (c) 2016年 Celestial Being. All rights reserved.
//

#import "PictureNewsTableViewCell.h"

@implementation PictureNewsTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_newsTitle release];
    [_sourceBtn release];
    [_newsImage release];
    [super dealloc];
}
@end
