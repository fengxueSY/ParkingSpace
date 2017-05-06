//
//  ConfirmRentController+creatUI.m
//  CheWei
//
//  Created by shenyang on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ConfirmRentController+creatUI.h"

@implementation ConfirmRentController (creatUI)
#pragma mark -- 创建基础界面
-(void)creatBaseUI{
    self.confirmTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight * 2 / 3)];
    self.confirmTableView.delegate = self;
    self.confirmTableView.dataSource = self;
    self.confirmTableView.scrollEnabled = NO;
    [self.view addSubview:self.confirmTableView];
    
//确认选择项
    UIButton * payButton = [CreatUI creatButtonWithTitle:@"支付" TitleColor:BLACK_color Frame:CGRectMake(WindowWidth / 4,CGRectGetMaxY(self.confirmTableView.frame) + 10, WindowWidth / 2, WindowHeight / 11) SetMasks:YES SetCorner:10 BackgroudColor:RGBcolor(190, 190, 190, 1) BackgroudImage:nil];
    [payButton addTarget:self action:@selector(payButtonForPark) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
}
@end
