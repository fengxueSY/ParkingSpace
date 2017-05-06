//
//  Rent_parlIDCell.m
//  CheWei
//
//  Created by shenyang on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Rent_parlIDCell.h"

@implementation Rent_parlIDCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellW = WindowWidth * 62 / 64;
        float cellH = WindowHeight / 13;
        
        _parkAddress = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cellW, cellH / 2)];
        _parkAddress.textColor = BLACK_color;
        [self.contentView addSubview:_parkAddress];
        
        _latitudeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cellH / 2, cellW / 2, cellH / 2)];
        _latitudeLabel.textColor = BLACK_color;
        [self.contentView addSubview:_latitudeLabel];
        _longitudeLabel = [[UILabel alloc]initWithFrame:CGRectMake(cellW / 2, cellH / 2, cellW / 2, cellH / 2)];
        _longitudeLabel.textColor = BLACK_color;
        [self.contentView addSubview:_longitudeLabel];
        
//        _parkAddress.backgroundColor = [UIColor brownColor];
//        _latitudeLabel.backgroundColor = [UIColor blueColor];
//        _longitudeLabel.backgroundColor = [UIColor yellowColor];
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
