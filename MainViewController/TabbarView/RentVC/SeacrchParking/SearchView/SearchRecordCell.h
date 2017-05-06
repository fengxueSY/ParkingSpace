//
//  SearchRecordCell.h
//  CheWei
//
//  Created by shenyang on 16/4/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchRecordCell : UITableViewCell
@property (nonatomic,strong) UILabel * addressLabel;
@property (nonatomic,strong) UILabel * timeLabel;/**<创建时间*/
@property (nonatomic,strong) UILabel * offectiveLabel;/**<有效时间*/
@property (nonatomic,strong) UILabel * startAndEndLabel;/**<开始和结束时间*/

@property (nonatomic,strong) UIButton * offectiveButton;
@property (nonatomic,strong) UIButton * cleacButton;
@property (nonatomic,strong) UIButton * oftenButton;

@property (nonatomic,strong) UILabel * lineLabel;
@end
