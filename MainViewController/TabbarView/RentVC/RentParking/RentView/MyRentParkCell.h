//
//  MyRentParkCell.h
//  CheWei
//
//  Created by shenyang on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRentParkCell : UITableViewCell
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * typeLabel;
@property (nonatomic,strong) UILabel * phoneLabel;
@property (nonatomic,strong) UILabel * addressLabel;
@property (nonatomic,strong) UILabel * priceLabel;
@property (nonatomic,strong) UIView * imageThreeView;
@property (nonatomic,strong) UIButton * oftenButton;
@property (nonatomic,strong) UIButton * editorButton;
@property (nonatomic,strong) UIButton * cleanButton;
@property (nonatomic,strong) UIButton * publishButton;
@property (nonatomic,strong) UILabel * lineLabel;
@end
