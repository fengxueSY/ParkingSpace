//
//  RecordController+creatUI.m
//  CheWei
//
//  Created by shenyang on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecordController+creatUI.h"

@implementation RecordController (creatUI)
-(void)creatBaseUI{
    self.recordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    [self.view addSubview:self.recordTableView];
}
@end
