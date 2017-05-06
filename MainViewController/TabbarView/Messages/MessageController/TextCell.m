//
//  TextCell.m
//  CheWei
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TextCell.h"

@implementation TextCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float cellHeight = WindowHeight / 6;
        self.addressLabel = [[UILabel alloc]init];
        self.addressLabel.frame = CGRectMake(WindowWidth / 32, cellHeight / 5, WindowWidth / 2, cellHeight / 3);
        self.addressLabel.backgroundColor = ORANGE_color;
        [self addSubview:self.addressLabel];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.frame = CGRectMake(WindowWidth / 32, Max_Y(self.addressLabel), WindowWidth / 2, cellHeight / 3);
        self.timeLabel.backgroundColor = GRAY_color;
        [self addSubview:self.timeLabel];
        
        self.beginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.beginButton.frame = CGRectMake(WindowWidth * 5 / 8, cellHeight / 3, WindowWidth / 4, cellHeight / 3);
        self.beginButton.backgroundColor = BLACK_color;
        [self.beginButton setTitle:@"开始找" forState:UIControlStateNormal];
        self.beginButton.titleLabel.font = FONT_size(16);
        [self addSubview:self.beginButton];
        
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
