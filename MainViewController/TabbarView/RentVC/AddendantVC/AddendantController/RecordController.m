//
//  RecordController.m
//  CheWei
//
//  Created by shenyang on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RecordController.h"
#import "RecordController+creatUI.h"
#import "RecordCell.h"

@interface RecordController (){
    NSMutableArray * _dataArray;
}

@end

@implementation RecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"操作记录";
    _dataArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}
#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[RecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
