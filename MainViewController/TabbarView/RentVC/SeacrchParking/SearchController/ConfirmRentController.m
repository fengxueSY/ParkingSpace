//
//  ConfirmRentController.m
//  CheWei
//
//  Created by shenyang on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ConfirmRentController.h"
#import "ConfirmRentController+creatUI.h"

@interface ConfirmRentController (){
    NSIndexPath * selectIndex;
    NSArray * payArray;
}

@end

@implementation ConfirmRentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择付款方式";
    payArray = @[@"余额",@"支付宝",@"微信",@"银行卡",@"Apple Pay"];
    [self creatBaseUI];
}
-(void)viewWillAppear:(BOOL)animated{
//确定默认选项，默认余额支付
    selectIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.confirmTableView selectRowAtIndexPath:selectIndex animated:YES scrollPosition:UITableViewScrollPositionNone];
}
#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 11;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return WindowHeight / 7;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    float headW = WindowWidth;
    float headH = WindowHeight / 7;
    for (int i = 0;  i < 3; i ++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(headW / 32, headH * i / 3, headW * 30 / 32, headH / 3)];
        if (i == 0) {
            label.text = [NSString stringWithFormat:@"订单号：%@",[_payDic objectForKey:@"sn"]];
        }
        if (i == 1) {
            label.text = [NSString stringWithFormat:@"订单金额：%@",[_payDic objectForKey:@"amount"]];
        }
        if (i == 2) {
            label.text = [NSString stringWithFormat:@"订单说明：%@",[_payDic objectForKey:@"desc"]];
        }
        [headView addSubview:label];
    }
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([selectIndex isEqual:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = payArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectIndex) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:selectIndex];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    selectIndex = indexPath;
}
#pragma mark -- 支付
-(void)payButtonForPark{
    if (selectIndex.row == 0) {
        [self searchUserBalanceHttps];
    }
    if (selectIndex.row == 1) {
        TTAlert1(@"暂不支持支付宝", self);
    }
    if (selectIndex.row == 2) {
        TTAlert1(@"暂不支持微信", self);
    }
    if (selectIndex.row == 3) {
        TTAlert1(@"暂不支持银行卡", self);
    }
    if (selectIndex.row == 4) {
        TTAlert1(@"暂不支持Apple Pay", self);
    }
}
//首先查询余额
-(void)searchUserBalanceHttps{
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:self.baseInfo.myToken];
    [manager GET:[NSString searchUserBalance:self.baseInfo.myURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        NSLog(@"查询余额  %@",dic);
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            if ([[dic objectForKey:@"data"] doubleValue] < [[_payDic objectForKey:@"amount"] doubleValue]) {
                TTAlert1(@"余额不足，请充值", self);
            }else{
                [self balanceForParkPayHttps];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        L1(error);
    }];
}
//余额支付
-(void)balanceForParkPayHttps{
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:self.baseInfo.myToken];
    [manager POST:[NSString chooseBalancePay:[_payDic objectForKey:@"sn"] httpsUrl:self.baseInfo.myURL] parameters:@{@"uid":self.baseInfo.myUid,@"sn":[_payDic objectForKey:@"sn"]} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        NSLog(@"dic == %@   %@   %@",dic,[dic objectForKey:@"message"],self.baseInfo.myUid);
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            [self showHint:@"支付成功"];
        }else{
            TTAlert1([dic objectForKey:@"message"], self);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        L1(error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
