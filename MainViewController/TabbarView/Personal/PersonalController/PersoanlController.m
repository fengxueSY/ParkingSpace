//
//  PersoanlController.m
//  CheWei
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PersoanlController.h"
#import "PersoanlController+myViews.h"
#import "CellPersonal.h"

#import "SettingView.h"
#import "MoneyController.h"
#import "MonitifyNickname.h"
#import "WalletViewController.h"
#import "DepositController.h"
@interface PersoanlController ()

@end

@implementation PersoanlController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9106 green:1.0 blue:0.4412 alpha:1.0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMessage) name:@"SHEZHI" object:nil];
    
    [self personalViews];
    self.role = [[NSString alloc]init];
    self.role = Format_String(self.baseInfo.myRole);
    L2(self.baseInfo.myPhoneNumber, self.baseInfo.myTelephone);
    [self loadDataMessages];
}
-(void)loadDataMessages{
    if ([self.role isEqualToString:@"0"]) {
        self.dataTitle = @[@"手机号:",@"姓名:",@"联系电话:",@"常用车牌:",@"钱包:",@"押金:",@"支付方式:",@"退出"];
        self.messageData = @[self.baseInfo.myPhoneNumber,self.baseInfo.myNickName,self.baseInfo.myTelephone];
    }else{
        self.dataTitle = @[@"手机号:",@"姓名:",@"联系电话:",@"管理员提成:",@"管理的车场:",@"支付方式:",@"退出"];
        self.messageData = @[self.baseInfo.myPhoneNumber,self.baseInfo.myNickName,self.baseInfo.myTelephone];
    }

}
-(void)viewDidAppear:(BOOL)animated{
    NSString * code = [NSU_DayI defaultsRead:CHANGE_ME];
    if (Equarl_String(code, @"2")) {
        [self loadDataMessages];
        [self.personalTableView reloadData];
        [NSU_DayI defaultsSave:@"1" withKey:CHANGE_ME];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellPersonal * cell = [[CellPersonal alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cells"];
    cell.titileLable.text = self.dataTitle[indexPath.row];
    if (indexPath.row < self.messageData.count) {
        cell.dataLabel.text = self.messageData[indexPath.row];
    }
    if (indexPath.row == 0) {
        cell.dataLabel.text = self.baseInfo.myPhoneNumber;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //same
    if (indexPath.row == 1) {
        MonitifyNickname * monitifyVC = [[MonitifyNickname alloc]init];
        monitifyVC.title = @"修改昵称";
        monitifyVC.fromType = @"1";
        [self.navigationController pushViewController:monitifyVC animated:YES];
    }else if (indexPath.row == 2){
        MonitifyNickname * monitifyVC = [[MonitifyNickname alloc]init];
        monitifyVC.title = @"修改联系电话";
        monitifyVC.fromType = @"2";
        [self.navigationController pushViewController:monitifyVC animated:YES];

    }
    //difference
    if (Equarl_String(self.role, @"0")) {
        if (indexPath.row == 7) {
            [self signOut];
        }
//        if (indexPath.row == 5) {
//            MoneyController * moneyVC = [[MoneyController alloc]init];
//            [self.navigationController pushViewController:moneyVC animated:YES];
//        }
        if (indexPath.row == 3) {
            MonitifyNickname * monitifyVC = [[MonitifyNickname alloc]init];
            monitifyVC.title = @"修改车牌";
            monitifyVC.fromType = @"3";
            [self.navigationController pushViewController:monitifyVC animated:YES];
        }
        if (indexPath.row == 4) {
            WalletViewController * walletVC = [[WalletViewController alloc]init];
            [self.navigationController pushViewController:walletVC animated:YES];
        }
        if (indexPath.row == 5) {
            DepositController * deVC = [[DepositController alloc]init];
            deVC.title = @"押金";
            [self.navigationController pushViewController:deVC animated:YES];
        }
    }
    if (Equarl_String(self.role, @"1")) {
        if (indexPath.row == 6) {
            [self signOut];
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataTitle.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 10;
}
#pragma mark -- 设置
-(void)changeMessage{
     SettingView * setView = [[SettingView alloc]init];
    [self.navigationController pushViewController:setView animated:YES];
}
#pragma mark -- 退出登录
-(void)signOut{
    [RMUniversalAlert showAlertInViewController:self withTitle:@"提示" message:@"是否退出登录" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"确定"] tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex) {
        if (buttonIndex == 2) {
            [NSU_DayI defaultsRemove:PHONENUMBER];
            NSNotification * noti = [[NSNotification alloc]initWithName:@"rootViewChange" object:nil userInfo:@{@"code":@"2"}];
            [[NSNotificationCenter defaultCenter] postNotification:noti];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SHEZHI" object:nil];
}
@end
