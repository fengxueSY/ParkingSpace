//
//  ScanResultCell.m
//  CheWei
//
//  Created by shenyang on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ScanResultCell.h"

@implementation ScanResultCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellW = WindowWidth;
        float cellH = WindowHeight / 9;
    
        _nameLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, 0, cellW / 4, cellH) Text:nil TextFont:16 BackgroudColor:CLEAR_color TextColor:BLACK_color];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
        
        _contentLabel = [CreatUI creatLabelWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), 0, cellW - CGRectGetMaxX(_nameLabel.frame), cellH) Text:nil TextFont:15 BackgroudColor:nil TextColor:BLACK_color];
        [self.contentView addSubview:_contentLabel];
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
