//
//  WalletCell.h
//  CheWei
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletCell : UITableViewCell
@property(nonatomic,strong)UIButton * leftButton;
@property(nonatomic,strong)UIButton * rightButton;

@property(nonatomic,strong)UILabel * lable1;
@property(nonatomic,strong)UILabel * lable2;

@property(nonatomic,strong)UILabel * line1;
@property(nonatomic,strong)UILabel * line2;


+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;
@end
