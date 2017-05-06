//
//  SearchRecordController+creatUI.m
//  CheWei
//
//  Created by shenyang on 16/4/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchRecordController+creatUI.h"

@implementation SearchRecordController (creatUI)
-(void)creatBaseUI{
    self.recordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight - 64)];
    self.recordTableView.dataSource = self;
    self.recordTableView.delegate = self;
    self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.recordTableView];
}
@end
