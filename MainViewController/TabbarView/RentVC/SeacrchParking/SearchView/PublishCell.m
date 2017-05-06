//
//  PublishCell.m
//  CheWei
//
//  Created by shenyang on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PublishCell.h"

@implementation PublishCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellW = WindowWidth;
        float cellH = WindowHeight / 9;
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cellH / 6, cellW / 4, cellH * 2 / 3)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), cellH / 6, cellW - CGRectGetMaxX(_nameLabel.frame), cellH * 2 / 3)];
        [self.contentView addSubview:_textField];
        _textField.placeholder = @"点击选择";
        _textField.adjustsFontSizeToFitWidth = YES;
        _textField.minimumFontSize = 9;
        _textField.backgroundColor = [UIColor clearColor];
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
