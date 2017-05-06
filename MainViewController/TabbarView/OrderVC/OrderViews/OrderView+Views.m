//
//  OrderView+Views.m
//  CheWei
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderView+Views.h"

@implementation OrderView (Views)
-(void)baseOrderViews{
    self.baseSegment = [[UISegmentedControl alloc]initWithItems:@[@"找车位",@"放租"]];
    self.baseSegment.frame = CGRectMake(WindowWidth / 4, WindowHeight * 1 / 40 + 64, WindowWidth / 2, WindowHeight / 15);
    self.baseSegment.selectedSegmentIndex = 0;
    [self.view addSubview:self.baseSegment];
    
    self.baseScrollView = [[UIScrollView alloc]init];
    self.baseScrollView.frame = CGRectMake(0, Max_Y(self.baseSegment) + WindowHeight / 40, WindowWidth, WindowHeight);
    self.baseScrollView.contentSize = CGSizeMake(WindowWidth * 2, WindowHeight);
    self.baseScrollView.delegate = self;
    self.baseScrollView.pagingEnabled = YES;
    self.baseScrollView.alwaysBounceVertical = NO;
    self.baseScrollView.showsHorizontalScrollIndicator = NO;
    
    self.baseScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.baseScrollView];
    
    self.findTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, WindowWidth, WindowHeight - 64 - 46 - WindowHeight / 20 - WindowHeight / 15) style:UITableViewStylePlain];
    self.findTableView.backgroundColor = GRAY_color;
    self.findTableView.tableFooterView = [[UIView alloc]init];
    self.findTableView.delegate = self;
    self.findTableView.dataSource = self;
    self.findTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.baseScrollView addSubview:self.findTableView];
    
    self.rentTableView = [[UITableView alloc]initWithFrame:CGRectMake(WindowWidth, 0, WindowWidth, WindowHeight - 64 - 46 - WindowHeight / 20 - WindowHeight / 15) style:UITableViewStylePlain];
    self.rentTableView.backgroundColor = [UIColor redColor];
    self.rentTableView.tableFooterView = [[UIView alloc]init];
    self.rentTableView.delegate = self;
    self.rentTableView.dataSource = self;
    self.rentTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.baseScrollView addSubview:self.rentTableView];

}
@end
