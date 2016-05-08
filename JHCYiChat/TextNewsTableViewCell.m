//
//  TextNewsTableViewCell.m
//  课件YiChat
//
//  Created by 九条さくらこ on 16/4/21.
//  Copyright (c) 2016年 Celestial Being. All rights reserved.
//

#import "TextNewsTableViewCell.h"

@implementation TextNewsTableViewCell

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
    [_newsimage release];
    [_newsTitle release];
    [_newsContent release];
    [_newsSourceBtn release];
    [super dealloc];
}
@end
