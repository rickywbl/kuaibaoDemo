//
//  VideoTableViewCell.h
//  KuaiBaoDemo
//
//  Created by 王保霖 on 16/6/1.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *Title;
@property (strong, nonatomic) IBOutlet UIImageView *VideoImageView;
@property (strong, nonatomic) IBOutlet UIButton *PlayButton;
@property (strong, nonatomic) NSIndexPath * indexpath;
@property (strong, nonatomic) void(^ playBlock)(NSIndexPath *indexpath);
- (IBAction)Play:(UIButton *)sender;

@end
