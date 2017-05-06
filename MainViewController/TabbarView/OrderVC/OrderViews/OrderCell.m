//
//  OrderCell.m
//  CheWei
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellHeight = WindowHeight / 5;
        float wide = WindowWidth * 2 / 3;
        float slitWide = WindowWidth  / 64;
        self.orderNumberLabel = [[UILabel alloc]init];
        self.orderNumberLabel.frame = CGRectMake(slitWide, 0,wide,cellHeight / 5);
        self.orderNumberLabel.font = FONT_size(15);
//        self.orderNumberLabel.backgroundColor = ORANGE_color;
        [self addSubview:self.orderNumberLabel];
        
        self.orderAddressLabel = [[UILabel alloc]init];
        self.orderAddressLabel.frame = CGRectMake(slitWide, Max_Y(self.orderNumberLabel),wide, cellHeight  / 5);
        self.orderAddressLabel.font = FONT_size(15);
        [self addSubview:self.orderAddressLabel];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.frame = CGRectMake(slitWide, Max_Y(self.orderAddressLabel), wide, cellHeight / 5);
        self.timeLabel.font = FONT_size(14);
        [self addSubview:self.timeLabel];
        
        self.userLabel = [[UILabel alloc]init];
        self.userLabel.frame = CGRectMake(slitWide, Max_Y(self.timeLabel), WindowWidth / 2, cellHeight / 5);
        self.userLabel.adjustsFontSizeToFitWidth = YES;
        self.userLabel.font = FONT_size(15);
        [self addSubview:self.userLabel];
        
        self.statusLabel = [[UILabel alloc]init];
        self.statusLabel.frame = CGRectMake(slitWide, Max_Y(self.userLabel), WindowWidth / 2, cellHeight  / 5);
        self.statusLabel.font = FONT_size(16);
        self.statusLabel.adjustsFontSizeToFitWidth = YES;
        self.statusLabel.textAlignment = NSTextAlignmentCenter;
        self.statusLabel.textColor = [UIColor redColor];
//        self.statusLabel.backgroundColor = GRAY_color;
        [self addSubview:self.statusLabel];
        
        self.operateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.operateButton.frame = CGRectMake(Max_X(self.statusLabel) + WindowWidth / 32,CGRectGetMidY(self.userLabel.frame) - 2,WindowWidth * 7 / 32,cellHeight / 5 + cellHeight  / 10);
        [self.operateButton setTitle:@"扫码离场" forState:UIControlStateNormal];
//        self.operateButton.backgroundColor = ORANGE_color;
        self.operateButton.titleLabel.font = FONT_size(16);
        [self.operateButton setTitleColor:BLACK_color forState:UIControlStateNormal];
        self.operateButton.layer.cornerRadius = 3;
        self.operateButton.layer.borderWidth = 0.6;
        self.operateButton.layer.borderColor = [GRAY_color CGColor];
        [self addSubview:self.operateButton];
        
        self.detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.detailButton.frame = CGRectMake(Max_X(self.operateButton) + WindowWidth / 64, Min_Y(self.operateButton), WindowWidth * 7 / 32 - WindowWidth / 64, cellHeight / 5 + cellHeight / 10);
        [self.detailButton setTitle:@"详情" forState:UIControlStateNormal];
        [self.detailButton setTitleColor:BLACK_color forState:UIControlStateNormal];
//        self.detailButton.backgroundColor = GRAY_color;
        self.detailButton.titleLabel.font = FONT_size(16);
        self.detailButton.layer.cornerRadius = 3;
        self.detailButton.layer.borderColor = [GRAY_color CGColor];
        self.detailButton.layer.borderWidth = 0.6;
        [self addSubview:self.detailButton];
        
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.frame = CGRectMake(Max_X(self.orderAddressLabel), Min_Y(self.orderAddressLabel), WindowWidth / 3, cellHeight / 5);
//        self.priceLabel.backgroundColor = ORANGE_color;
        self.priceLabel.font = FONT_size(14);
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.priceLabel];
        
        self.tipsLabel = [[UILabel alloc]init];
        self.tipsLabel.frame = CGRectMake(Max_X(self.timeLabel), Min_Y(self.timeLabel), WindowWidth / 3, cellHeight  / 5);
        self.tipsLabel.font = FONT_size(13);
        self.tipsLabel.textAlignment = NSTextAlignmentCenter;
//        self.tipsLabel.backgroundColor = GRAY_color;
        [self addSubview:self.tipsLabel];
        
        
        
        
        
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
