//
//  WalletViewController+views.m
//  CheWei
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WalletViewController+views.h"

@implementation WalletViewController (views)
-(void)baseWalletViews{
    self.walletTableView = [[UITableView alloc]init];
    self.walletTableView.frame = CGRectMake(0,0,WindowWidth,WindowHeight);
    self.walletTableView.delegate = self;
    self.walletTableView.dataSource = self;
    self.walletTableView.separatorColor = CLEAR_color;
    self.walletTableView.tableFooterView = [[UIView alloc]init];
    self.walletTableView.backgroundColor = CLEAR_color;
    [self.view addSubview:self.walletTableView];
}
@end
