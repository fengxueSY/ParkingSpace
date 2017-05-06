//
//  PersoanlController+myViews.m
//  CheWei
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PersoanlController+myViews.h"

@implementation PersoanlController (myViews)
-(void)personalViews{
    self.personalTableView = [[UITableView alloc]init];
    self.personalTableView.frame = CGRectMake(0, 0, WindowWidth, WindowHeight - barHeight44);
    self.personalTableView.delegate = self;
    self.personalTableView.dataSource = self;
    self.personalTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.personalTableView];
}
@end
