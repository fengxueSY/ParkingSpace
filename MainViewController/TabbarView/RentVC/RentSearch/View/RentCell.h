//
//  RentCell.h
//  CheWei
//
//  Created by shenyang on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentCell : UITableViewCell
@property (nonatomic,strong) UILabel * addressLabel;
@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong) UILabel * typePark;
@property (nonatomic,strong) UIButton * startButton;
@property (nonatomic,strong) UIButton * otherButton;
@property (nonatomic,strong) UIButton * deleteButton;
@property (nonatomic,strong) UILabel * lineLabel;

@end
