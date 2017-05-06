//
//  MyRentParkController+creatUI.m
//  CheWei
//
//  Created by shenyang on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyRentParkController+creatUI.h"

@implementation MyRentParkController (creatUI)
-(void)creatBaseUI{
    self.displayTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight - 64)];
    self.displayTableView.dataSource = self;
    self.displayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.displayTableView.delegate = self;
    [self.view addSubview:self.displayTableView];
}
@end
