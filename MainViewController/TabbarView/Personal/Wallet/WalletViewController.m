//
//  WalletViewController.m
//  CheWei
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WalletViewController.h"
#import "WalletViewController+views.h"
#import "WalletCell.h"

#import "RechargeController.h"
#import "WithdrawalsController.h"
#import "BalanceBillController.h"
#import "TransactionRecordController.h"
@interface WalletViewController ()
@property(nonatomic,strong)NSString * totalMoney;
@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBcolor(220, 220, 220, 1);
    self.title = @"我的钱包";
    self.totalMoney = @"0.00元";
    [self baseWalletViews];
    self.walletTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadMessage)];
    [self showHudInView:self.view hint:@"获取中..."];
    [self myWalletHTTPS];
}
-(void)leftAction:(UIButton *)sender{
    if (sender.tag == 1000) {
        L1(@"充值");
        RechargeController * rechargrVC = [[RechargeController alloc]init];
        rechargrVC.title = @"充值";
        [self.navigationController pushViewController:rechargrVC animated:YES];
    }
    if (sender.tag == 1001) {
        L1(@"余额账单");
        BalanceBillController * balanceVC = [[BalanceBillController alloc]init];
        balanceVC.title = @"余额账单";
        [self.navigationController pushViewController:balanceVC animated:YES];
    }
}
-(void)rightActon:(UIButton *)sender{
    if (sender.tag == 2000) {
        L1(@"提现");
        WithdrawalsController * drawVC = [[WithdrawalsController alloc]init];
        drawVC.title = @"提现";
        [self.navigationController pushViewController:drawVC animated:YES];
    }
    if (sender.tag == 2001) {
        L1(@"交易记录");
        TransactionRecordController * recordVC = [[TransactionRecordController alloc]init];
        recordVC.title = @"交易记录";
        [self.navigationController pushViewController:recordVC animated:YES];
    }
}
#pragma mark -- 下拉刷新
-(void)reloadMessage{
    [self myWalletHTTPS];
}
#pragma mark -- tableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WalletCell * cell = [WalletCell cellWithTableView:tableView andIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        double money = [self.totalMoney doubleValue];
        NSString * s1 = [NSString stringWithFormat:@"%.2f元",money];
        cell.textLabel.text = Stitch_String(@"账户余额: ", s1);
    }
    if (indexPath.section == 1) {
        cell.leftButton.tag = indexPath.row + 1000;
        cell.rightButton.tag = indexPath.row + 2000;
        [cell.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchDown];
        [cell.rightButton addTarget:self action:@selector(rightActon:) forControlEvents:UIControlEventTouchDown];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return WindowHeight / 8;
    }
    return WindowHeight / 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0;
    }
    return WindowHeight / 40;
}
#pragma mark -- data
-(void)myWalletHTTPS{
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_XML:self.baseInfo.myToken];
    [manager GET:Stitch_String(self.baseInfo.myURL, @"/api/wallet/balance/total") parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if (Equarl_stringCode0(Format_String(dic[@"code"]))) {
            NSString * data = Format_String(dic[@"data"]);
            NSString * data1 = [data stringByReplacingOccurrencesOfString:@"-" withString:@""];
            self.totalMoney = data1;
        }else{
            [self showHint:Format_String(dic[@"message"])];
        }
        NSIndexPath * pa = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.walletTableView reloadRowsAtIndexPaths:@[pa] withRowAnimation:UITableViewRowAnimationRight];
        [self.walletTableView.mj_header endRefreshing];
        [self hideHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
        [self.walletTableView.mj_header endRefreshing];
        [self showHint:@"获取失败!"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
@end
