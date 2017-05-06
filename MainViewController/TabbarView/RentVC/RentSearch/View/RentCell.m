//
//  RentCell.m
//  CheWei
//
//  Created by shenyang on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RentCell.h"

@implementation RentCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float w = WindowWidth;
        float h = (WindowHeight - 64) * 11 / 54;
        
        _addressLabel = [CreatUI creatLabelWithFrame:CGRectMake(w / 32, h / 12, w * 23 / 32, h * 3 / 6) Text:nil TextFont:16 BackgroudColor:[UIColor clearColor] TextColor:[UIColor blackColor]];
        _addressLabel.numberOfLines = 0;
        [self.contentView addSubview:_addressLabel];
        
        _typePark = [CreatUI creatLabelWithFrame:CGRectMake(w / 32, CGRectGetMaxY(_addressLabel.frame), w * 16 / 32, h * 2 / 6) Text:nil TextFont:15 BackgroudColor:nil TextColor:RGBcolor(150, 150, 150, 1)];
        _typePark.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_typePark];
        
        _timeLabel = [CreatUI creatLabelWithFrame:CGRectMake(CGRectGetMaxX(_typePark.frame), CGRectGetMaxY(_addressLabel.frame), w * 13 / 32, h * 2 / 6) Text:nil  TextFont:15 BackgroudColor:nil TextColor:RGBcolor(150, 150, 150, 1)];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_timeLabel];
        
        _startButton = [CreatUI creatButtonWithTitle:@"租放" TitleColor:[UIColor blueColor] Frame:CGRectMake(w * 25 / 32, h / 9, w * 6 / 32, h / 3) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor clearColor] BackgroudImage:nil];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_startButton];
        
        _deleteButton = [CreatUI creatButtonWithTitle:@"删除" TitleColor:[UIColor blueColor] Frame:CGRectMake(w * 25 / 32, h * 5 / 9, w * 6 / 32, h / 3) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor clearColor] BackgroudImage:nil];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_deleteButton];

        
        _otherButton = [CreatUI creatButtonWithTitle:nil TitleColor:[UIColor blackColor] Frame:CGRectMake(w / 4, h / 4, w / 2, h / 2) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(230, 230, 230, 1) BackgroudImage:nil];
        [self.contentView addSubview:_otherButton];

        _lineLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, h - 0.5, w, 0.5) Text:nil TextFont:0 BackgroudColor:RGBcolor(230, 230, 230, 1) TextColor:nil];
        [self.contentView addSubview:_lineLabel];

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
