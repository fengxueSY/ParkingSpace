//
//  OrderCell.h
//  CheWei
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property(nonatomic,strong)UILabel * orderNumberLabel;
@property(nonatomic,strong)UILabel * orderAddressLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * userLabel;
@property(nonatomic,strong)UILabel * statusLabel;
@property(nonatomic,strong)UILabel * priceLabel;
@property(nonatomic,strong)UILabel * tipsLabel;

@property(nonatomic,strong)UIButton * detailButton;
@property(nonatomic,strong)UIButton * operateButton;
@end
