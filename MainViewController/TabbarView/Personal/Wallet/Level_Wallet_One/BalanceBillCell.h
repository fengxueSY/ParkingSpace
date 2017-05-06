//
//  BalanceBillCell.h
//  CheWei
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalanceBillCell : UITableViewCell
@property(nonatomic,strong)UILabel * typeLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * amountLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
