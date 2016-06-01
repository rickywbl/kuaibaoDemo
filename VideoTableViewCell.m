//
//  VideoTableViewCell.m
//  KuaiBaoDemo
//
//  Created by 王保霖 on 16/6/1.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)Play:(UIButton *)sender {

    if(_playBlock){
    
        self.playBlock(self.indexpath);
    }
}
@end
