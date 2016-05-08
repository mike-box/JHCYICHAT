//
//  TableViewCell.m
//  JHCYiChat
//
//  Created by 九条さくらこ on 16/4/2.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled=YES;
        _headerImage=[UIButton buttonWithType:UIButtonTypeCustom];
        _headerImage.frame=CGRectMake(10, 10, 55, 55);
        _headerImage.layer.cornerRadius=27.5;
        _headerImage.clipsToBounds=YES;
        [self addSubview:_headerImage];
        
        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 10, 150, 20)];
        _nameLabel.font=[UIFont systemFontOfSize:13.0];
        [self addSubview:_nameLabel];
        
        _messageLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 35, 200, 30)];
        _messageLabel.numberOfLines=0;
        _messageLabel.font=[UIFont systemFontOfSize:10.0];
        _messageLabel.text=@"此人很懒，没有写下任何签名";
        [self addSubview:_messageLabel];
        
        _messageNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(280, 25, 30, 30)];
        _messageNumLabel.backgroundColor=[UIColor colorWithRed:255/255.0 green:129/255.0 blue:122/255.0 alpha:1];
        _messageNumLabel.layer.cornerRadius=15;
        _messageNumLabel.clipsToBounds=YES;
        _messageNumLabel.textAlignment=NSTextAlignmentCenter;
        _messageNumLabel.textColor=[UIColor whiteColor];
        _messageNumLabel.text=@"0";
        [self addSubview:_messageNumLabel];
        
        
        
    }
    return self;
}
- (void)dealloc
{
    [_headerImage release];
    [_nameLabel release];
    [_messageLabel release];
    [_messageNumLabel release];
    [super dealloc];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
