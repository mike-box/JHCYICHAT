//
//  ChatTableViewCell.m
//  JHCYiChat
//
//  Created by 九条桜子 on 16/4/17.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headerImageView = [[UIImageView alloc]init];
        [self addSubview:_headerImageView];
        _contentImageView = [[UIImageView alloc]init];
        [self addSubview:_contentImageView];
        _contentLabel = [[UILabel alloc]init];
        //        自动换行
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
        //        设置单元格的选中样式为空
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //        把cell的背景设置为透明
        self.backgroundColor = [UIColor clearColor];
        
        
        // Initialization code
    }
    return self;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
