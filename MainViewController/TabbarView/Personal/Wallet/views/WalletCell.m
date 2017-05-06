//
//  WalletCell.m
//  CheWei
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WalletCell.h"

@implementation WalletCell
+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"status";
    // 1.缓存中取
    WalletCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
     // 2.创建
     if (cell == nil) {
         cell = [[WalletCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier andIndexPath:indexPath];
     }
    return cell;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellHeight = WindowHeight / 8;
        if (indexPath.section == 1) {
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = CGRectMake(0, 0,WindowWidth / 2, cellHeight);
        self.leftButton.backgroundColor = CLEAR_color;
        [self.contentView addSubview:self.leftButton];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame = CGRectMake(WindowWidth / 2,0,WindowWidth / 2, cellHeight);
        self.rightButton.backgroundColor = CLEAR_color;
        [self.contentView addSubview:self.rightButton];

            
        self.lable1 = [[UILabel alloc]init];
        self.lable1.frame = CGRectMake(0, cellHeight / 3, WindowWidth / 2, cellHeight / 3);
        self.lable1.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lable1];
        
        self.lable2 = [[UILabel alloc]init];
        self.lable2.frame = CGRectMake(WindowWidth / 2, cellHeight / 3, WindowWidth / 2, cellHeight / 3);
        self.lable2.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lable2];

        
        self.line2 = [[UILabel alloc]init];
        self.line2.frame = CGRectMake(WindowWidth / 2, 3, 0.3, cellHeight - 6);
        self.line2.backgroundColor = GRAY_color;
        [self.contentView addSubview:self.line2];

        if (indexPath.row == 0) {
            self.line1 = [[UILabel alloc]init];
            self.line1.frame = CGRectMake(WindowWidth / 32, cellHeight - 0.4, WindowWidth, 0.3);
            self.line1.backgroundColor = GRAY_color;
            [self.contentView addSubview:self.line1];
            
            self.lable1.text = @"充值";
            self.lable2.text = @"提现";
        }else if (indexPath.row == 1){
            self.lable1.text = @"余额账单";
            self.lable2.text = @"交易记录";
        }
            
      }
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
