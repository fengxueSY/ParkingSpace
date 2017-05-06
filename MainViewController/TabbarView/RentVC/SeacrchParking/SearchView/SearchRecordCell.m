//
//  SearchRecordCell.m
//  CheWei
//
//  Created by shenyang on 16/4/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchRecordCell.h"

@implementation SearchRecordCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellW = WindowWidth;
        float cellH = WindowHeight / 5;
        float textSize;
        if (WindowWidth == 375) {
            textSize = 15;
        }else if (WindowWidth == 320){
            textSize = 13;
        }else{
            textSize = 14;
        }
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(cellW / 64, 0, cellW * 62 / 64, cellH / 4)];
        _addressLabel.font = [UIFont systemFontOfSize:textSize];
        [self.contentView addSubview:_addressLabel];
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(cellW / 64, CGRectGetMaxY(_addressLabel.frame), cellW * 37 / 64, cellH / 4)];
        _timeLabel.font = [UIFont systemFontOfSize:textSize];
        [self.contentView addSubview:_timeLabel];
        
        _offectiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_timeLabel.frame), CGRectGetMaxY(_addressLabel.frame), cellW * 24 / 64, cellH / 4)];
        _offectiveLabel.font = [UIFont systemFontOfSize:textSize];
        _offectiveLabel.textAlignment = NSTextAlignmentRight;
        _startAndEndLabel = [[UILabel alloc]initWithFrame:CGRectMake(cellW / 64, CGRectGetMaxY(_timeLabel.frame), cellW * 62 / 64, cellH / 4)];
        _startAndEndLabel.font = [UIFont systemFontOfSize:textSize];
        [self.contentView addSubview:_offectiveLabel];
        [self.contentView addSubview:_startAndEndLabel];
        
//        _addressLabel.backgroundColor = [UIColor redColor];
//        _timeLabel.backgroundColor = [UIColor orangeColor];
//        _offectiveLabel.backgroundColor = [UIColor brownColor];
        
        _oftenButton = [CreatUI creatButtonWithTitle:nil TitleColor:[UIColor blueColor] Frame:CGRectMake(cellW / 16, CGRectGetMaxY(_startAndEndLabel.frame), cellW / 4, cellH / 4 - 1) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor clearColor] BackgroudImage:nil];
        _oftenButton.layer.borderWidth = 1;
        _oftenButton.layer.borderColor = [UIColor blueColor].CGColor;
        _oftenButton.layer.cornerRadius = 5;
        _oftenButton.titleLabel.font = [UIFont systemFontOfSize:textSize];
        [self.contentView addSubview:_oftenButton];
        _offectiveButton = [CreatUI creatButtonWithTitle:nil TitleColor:[UIColor blueColor] Frame:CGRectMake(CGRectGetMaxX(_oftenButton.frame) + cellW / 16, CGRectGetMaxY(_startAndEndLabel.frame), cellW / 4, cellH / 4 - 1) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor clearColor] BackgroudImage:nil];
        _offectiveButton.layer.borderWidth = 1;
        _offectiveButton.layer.borderColor = [UIColor blueColor].CGColor;
        _offectiveButton.layer.cornerRadius = 5;
        _offectiveButton.titleLabel.font = [UIFont systemFontOfSize:textSize];
        [self.contentView addSubview:_offectiveButton];
        
        _cleacButton = [CreatUI creatButtonWithTitle:@"删除" TitleColor:[UIColor blueColor] Frame:CGRectMake(CGRectGetMaxX(_offectiveButton.frame) + cellW / 16, CGRectGetMaxY(_startAndEndLabel.frame), cellW / 4, cellH / 4 - 1) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor clearColor] BackgroudImage:nil];
        _cleacButton.titleLabel.font = [UIFont systemFontOfSize:textSize];
        _cleacButton.layer.borderWidth = 1;
        _cleacButton.layer.borderColor = [UIColor blueColor].CGColor;
        _cleacButton.layer.cornerRadius = 5;
        [self.contentView addSubview:_cleacButton];
        
        _lineLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, cellH - 0.5, cellW, 0.5) Text:nil TextFont:0 BackgroudColor:RGBcolor(150, 150, 150, 1) TextColor:nil];
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
