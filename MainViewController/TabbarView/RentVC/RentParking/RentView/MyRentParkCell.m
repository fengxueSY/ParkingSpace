//
//  MyRentParkCell.m
//  CheWei
//
//  Created by shenyang on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyRentParkCell.h"

@implementation MyRentParkCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellW = WindowWidth;
        float cellH = WindowHeight / 3;
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(cellW / 64, 0, cellW * 28 / 64, cellH / 6)];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_nameLabel];
        
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame) + 2, 0, cellW * 35 / 64, cellH / 6)];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_typeLabel];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(cellW / 64, CGRectGetMaxY(_nameLabel.frame), cellW * 31 / 64, cellH / 6)];
        _phoneLabel.adjustsFontSizeToFitWidth = YES;
        _phoneLabel.minimumScaleFactor = 0.5;
        [self.contentView addSubview:_phoneLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(cellW / 2, CGRectGetMaxY(_nameLabel.frame), cellW * 31 / 64, cellH / 6)];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_priceLabel];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(cellW / 64, CGRectGetMaxY(_priceLabel.frame), cellW * 62 / 64, cellH / 6)];
        _addressLabel.adjustsFontSizeToFitWidth = YES;
        _addressLabel.minimumScaleFactor = 0.5;
        [self.contentView addSubview:_addressLabel];
        
        _imageThreeView = [[UIView alloc]initWithFrame:CGRectMake(cellW / 64, CGRectGetMaxY(_addressLabel.frame), cellW * 62 / 64, cellH * 2 / 6)];
        [self.contentView addSubview:_imageThreeView];
        
        
        _oftenButton = [CreatUI creatButtonWithTitle:nil TitleColor:[UIColor blueColor] Frame:CGRectMake(cellW / 30, CGRectGetMaxY(_imageThreeView.frame), cellW * 5 / 24, cellH / 6 - 1) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor yellowColor] BackgroudImage:nil];
        _oftenButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _oftenButton.layer.borderWidth = 1;
        _oftenButton.layer.borderColor = RGBcolor(190, 190, 190, 1).CGColor;
        _oftenButton.layer.cornerRadius = 5;
        [self.contentView addSubview:_oftenButton];
        
        _editorButton = [CreatUI creatButtonWithTitle:@"编辑" TitleColor:[UIColor blueColor] Frame:CGRectMake(CGRectGetMaxX(_oftenButton.frame) + cellW / 30, CGRectGetMaxY(_imageThreeView.frame), cellW * 5 / 24, cellH / 6 - 2) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor greenColor] BackgroudImage:nil];
        _editorButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _editorButton.layer.borderWidth = 1;
        _editorButton.layer.borderColor = RGBcolor(190, 190, 190, 1).CGColor;
        _editorButton.layer.cornerRadius = 5;
        [self.contentView addSubview:_editorButton];
        
        _cleanButton = [CreatUI creatButtonWithTitle:@"删除" TitleColor:[UIColor blueColor] Frame:CGRectMake(CGRectGetMaxX(_editorButton.frame) + cellW / 30, CGRectGetMaxY(_imageThreeView.frame), cellW * 5 / 24, cellH / 6 - 2) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor greenColor] BackgroudImage:nil];
        _cleanButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _cleanButton.layer.borderWidth = 1;
        _cleanButton.layer.borderColor = RGBcolor(190, 190, 190, 1).CGColor;
        _cleanButton.layer.cornerRadius = 5;
        [self.contentView addSubview:_cleanButton];
        
        _publishButton = [CreatUI creatButtonWithTitle:@"租放" TitleColor:[UIColor blueColor] Frame:CGRectMake(CGRectGetMaxX(_cleanButton.frame) + cellW / 30, CGRectGetMaxY(_imageThreeView.frame), cellW * 5 / 24, cellH / 6 - 2) SetMasks:YES SetCorner:5 BackgroudColor:[UIColor greenColor] BackgroudImage:nil];
        _publishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _publishButton.layer.borderWidth = 1;
        _publishButton.layer.borderColor = RGBcolor(190, 190, 190, 1).CGColor;
        _publishButton.layer.cornerRadius = 5;
        [self.contentView addSubview:_publishButton];

        _lineLabel = [CreatUI creatLabelWithFrame:CGRectMake(0, cellH - 1, cellW, 0.5) Text:nil TextFont:0 BackgroudColor:RGBcolor(150, 150, 150, 1) TextColor:nil];
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
