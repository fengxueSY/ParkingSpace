//
//  BalanceBillController.m
//  CheWei
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BalanceBillController.h"
#import "BalanceBillCell.h"
@interface BalanceBillController ()

@end

@implementation BalanceBillController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBcolor(220, 220, 220, 1);
    self.title = @"余额账单列表";
    
    self.dayTableView = [[UITableView alloc]init];
    self.dayTableView.frame = CGRectMake(0, 0,WindowWidth,WindowHeight - barHeight64);
    self.dayTableView.delegate = self;
    self.dayTableView.dataSource = self;
    self.dayTableView.separatorColor = GRAY_color;
    self.dayTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadMessage)];
    [self.view addSubview:self.dayTableView];
    
    [self showHudInView:self.view hint:@"获取中"];
    [self balanceHttps:@"1"];
}
-(void)reloadMessage{
    [self balanceHttps:@"1"];
}
-(void)balanceHttps:(NSString *)page{
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_XML:self.baseInfo.myToken];
    [manager GET:[NSString stringWithFormat:@"%@/api/wallet/balance/p/%@",self.baseInfo.myURL,page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        L1(dic);
        NSString * code = Format_String(dic[@"code"]);
        if (Equarl_stringCode0(code)) {
            
        }else{
            NSString * message = Format_String(dic[@"message"]);
            [self showHint:message];
        }
        [self hideHud];
        [self.dayTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
        [self showHint:@"获取失败!"];
        [self.dayTableView.mj_header endRefreshing];
    }];
}
#pragma mark -- tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BalanceBillCell * cell = [BalanceBillCell cellWithTableView:tableView];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
