//
//  BalanceBillCell.m
//  CheWei
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BalanceBillCell.h"

@implementation BalanceBillCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * cell2 = @"cells";
    BalanceBillCell * cell = [tableView dequeueReusableCellWithIdentifier:cell2];
    if (cell == nil) {
        cell = [[BalanceBillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellHeight = WindowHeight / 10;
        
        self.typeLabel = [[UILabel alloc]init];
        self.typeLabel.frame = CGRectMake(WindowWidth / 32, cellHeight / 4, WindowWidth / 4, cellHeight / 2);
        self.typeLabel.backgroundColor = CLEAR_color;
        self.typeLabel.text = @"账户充值";
        self.typeLabel.adjustsFontSizeToFitWidth = YES;
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.typeLabel];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.frame = CGRectMake(Max_X(self.typeLabel),Min_Y(self.typeLabel),WindowWidth / 3, cellHeight / 2);
        self.timeLabel.backgroundColor = CLEAR_color;
        self.timeLabel.text = @"2015-5-16 12:21";
        self.timeLabel.font = FONT_size(14);
        self.timeLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.timeLabel];
        
        self.amountLabel = [[UILabel alloc]init];
        self.amountLabel.frame = CGRectMake(Max_X(self.timeLabel), cellHeight / 4, WindowWidth * 17 / 48, cellHeight / 2);
        self.amountLabel.backgroundColor = CLEAR_color;
        self.amountLabel.textAlignment = NSTextAlignmentCenter;
        self.amountLabel.text = @"-100";
        self.amountLabel.font = FONT_size(16);
        [self.contentView addSubview:self.amountLabel];
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
