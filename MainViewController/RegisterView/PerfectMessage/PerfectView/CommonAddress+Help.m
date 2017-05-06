//
//  CommonAddress+Help.m
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CommonAddress+Help.h"

@implementation CommonAddress (Help)
-(void)loadCommonAddressView{
    UIView * backView = [[UIView alloc]init];
    backView.frame = CGRectMake(WindowWidth / 8, WindowHeight / 15, WindowWidth * 6 / 8, WindowHeight / 14);
    backView.backgroundColor = WHITE_color;
    [self.view addSubview:backView];
    
    UILabel * label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(WindowWidth / 8, WindowHeight / 15, WindowWidth / 8, WindowHeight / 14);
    label1.text = @" 姓名:";
    label1.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label1];
    
    self.nameField = [[UITextField alloc]init];
    self.nameField.frame = CGRectMake(Max_X(label1), Min_Y(label1), WindowWidth * 5 / 8, WindowHeight / 14);
    self.nameField.placeholder = @" 默认所有订单的联系人";
    self.nameField.font = FONT_size(16);
    self.nameField.returnKeyType = UIReturnKeyDone;
    self.nameField.delegate = self;
    [self.view addSubview:self.nameField];
    
    
    UIView * view2 = [[UIView alloc]init];
    view2.frame = CGRectMake(WindowWidth / 8, Max_Y(backView) + WindowHeight / 60, WindowWidth * 6 / 8, WindowHeight / 14);
    view2.backgroundColor = WHITE_color;
    [self.view addSubview:view2];

    UILabel * label2 = [[UILabel alloc]init];
    label2.frame = CGRectMake(WindowWidth / 8, Min_Y(view2), WindowWidth / 4, WindowHeight / 14);
    label2.text = @" 手机联系人:";
    label2.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label2];
    
    self.phoneField = [[UITextField alloc]init];
    self.phoneField.delegate = self;
    self.phoneField.frame = CGRectMake(Max_X(label2), Min_Y(label2), WindowWidth * 4 / 8, WindowHeight / 14);
    self.phoneField.placeholder = @" 默认联系方式";
    self.phoneField.font = FONT_size(16);
    self.phoneField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.phoneField];
    
    self.boyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.boyButton.frame = CGRectMake(WindowWidth / 8 + WindowWidth / 64, Max_Y(view2) + WindowHeight / 60, WindowWidth * 3 / 16 + WindowWidth * 5 / 32, WindowHeight / 18);
    self.boyButton.backgroundColor = ORANGE_color;
    [self.boyButton setTitle:@"先生" forState:UIControlStateNormal];
    self.boyButton.layer.cornerRadius = 8;
    self.boyButton.titleLabel.font = FONT_size(17);
    [self.view addSubview:self.boyButton];
    
    self.girlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.girlButton.frame = CGRectMake(Max_X(self.boyButton) + WindowWidth / 32,Min_Y(self.boyButton), WindowWidth * 3 / 16 + + WindowWidth * 5 / 32, WindowHeight / 18);
    self.girlButton.backgroundColor = GRAY_color;
    [self.girlButton setTitle:@"女士" forState:UIControlStateNormal];
    self.girlButton.titleLabel.font = FONT_size(17);
    self.girlButton.layer.cornerRadius = 8;
    [self.view addSubview:self.girlButton];

    
    self.addressTableView = [[UITableView alloc]init];
    self.addressTableView.frame = CGRectMake(0, 0, WindowWidth, WindowHeight - barHeight64);
    self.addressTableView.delegate = self;
    self.addressTableView.dataSource = self;
    self.addressTableView.tableFooterView = [[UIView alloc]init];
//    [self.view addSubview:self.addressTableView];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmButton.frame =  CGRectMake(WindowWidth / 16, WindowHeight - barHeight64 - WindowHeight / 12 - WindowWidth / 16, WindowWidth * 14 / 16, WindowHeight / 12);
    [self.confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
    self.confirmButton.backgroundColor = [UIColor colorWithRed:0.9861 green:0.5981 blue:0.9313 alpha:1.0];
    self.confirmButton.layer.cornerRadius = 2;
    [self.view addSubview:self.confirmButton];
    
    self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.skipButton.frame =  CGRectMake(WindowWidth / 16 + CGRectGetMaxX(self.confirmButton.frame), WindowHeight / 2, WindowWidth * 13 / 32, WindowHeight / 12);
    [self.skipButton setTitle:@"先跳过" forState:UIControlStateNormal];
    self.skipButton.backgroundColor = [UIColor colorWithRed:0.6895 green:0.6082 blue:0.9649 alpha:1.0];
    self.skipButton.layer.cornerRadius = 2;
    self.skipButton.hidden = YES;
    [self.view addSubview:self.skipButton];

    
}
@end
