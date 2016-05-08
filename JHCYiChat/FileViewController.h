//
//  FileViewController.h
//  JHCYiChat
//
//  Created by 九条桜子 on 16/4/23.
//  Copyright (c) 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileViewController : UICollectionViewController

@property(nonatomic,retain)NSMutableArray *pubFileArray;
@property(nonatomic,retain)NSMutableArray *perFileArray;
@property(nonatomic,retain)NSMutableArray *fileArray;
@property(nonatomic,retain)NSMutableArray *downLoadFileArray;
@end
