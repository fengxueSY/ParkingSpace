//
//  TabBarView+views.m
//  CheWei
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TabBarView+views.h"

@implementation TabBarView (views)
-(void)loadMyView{
    self.info = Info_INIT;
    
    self.delegate = self;
    MessageController * messageVC = [[MessageController alloc]init];
    messageVC.tabBarItem.title = @"消息";
    messageVC.tabBarItem.tag = 1;
    messageVC.title = @"消息";
    
    OrderView * orderVC = [[OrderView alloc]init];
    orderVC.tabBarItem.title = @"订单信息";
    orderVC.tabBarItem.tag = 2;
    
//    RentViewController * rentVC = [[RentViewController alloc]init];
//    rentVC.tabBarItem.title = @"租放";
//    rentVC.tabBarItem.tag = 3;
    
    RentSearchController * rentVC = [[RentSearchController alloc]init];
    rentVC.tabBarItem.title = @"租放";
    rentVC.tabBarItem.tag = 3;
    
    PersoanlController * personalVC = [[PersoanlController alloc]init];
    personalVC.tabBarItem.title = @"我的";
    personalVC.tabBarItem.tag = 4;
    
    self.viewControllers = @[messageVC,orderVC,rentVC,personalVC];
    self.selectedIndex = 2;
    if (Equarl_String(Format_String(self.info.myRole), @"0")) {
        self.title = @"租放";
    }else{
       self.title = @"扫码";
    }
}
-(void)changeButtonTitle:(NSString *)titleStr{
    NSString * title;
    if (titleStr) {
        title = titleStr;
    }else{
        title = @"记录";
    }
    if ([titleStr isEqualToString:@"找车记录"]) {
        self.menuButton.tag = 1900000;
        self.menuButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }else if ([titleStr isEqualToString:@"常租放车位"]){
        self.menuButton.tag = 1900001;
        self.menuButton.titleLabel.font = [UIFont systemFontOfSize:12];
    }else if ([titleStr isEqualToString:@"操作记录"]){
        self.menuButton.tag = 1900003;
        self.menuButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }else{
        self.menuButton.tag = 1900002;
        self.menuButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }

    [self.menuButton setTitle:title forState:UIControlStateNormal];
}
-(void)baseButtons{
    self.newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.newsButton setTitle:@"消息" forState:UIControlStateNormal];
    self.newsButton.frame = CGRectMake(0, 0, 40, 20);
    self.newsButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.newsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithCustomView:self.newsButton];
    self.navigationItem.leftBarButtonItem = left;
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([self.info.myRole integerValue] == 0) {
        NSString * seg = [NSU_DayI defaultsRead:@"chooseSegementControlnumberOfSegments"];
        if (seg == nil || [seg integerValue] == 0) {
            [self.menuButton setTitle:@"找车记录" forState:UIControlStateNormal];
            self.menuButton.tag = 1900000;
            self.menuButton.titleLabel.font = [UIFont systemFontOfSize:13];
        }else if([seg integerValue] == 1){
            [self.menuButton setTitle:@"常放租车位" forState:UIControlStateNormal];
            self.menuButton.titleLabel.font = [UIFont systemFontOfSize:12];
            self.menuButton.tag = 1900001;
        }else{
            [self.menuButton setTitle:@"设置" forState:UIControlStateNormal];
            self.menuButton.titleLabel.font = [UIFont systemFontOfSize:15];
            self.menuButton.tag = 1900002;
        }
    }else{
        if ([self.title isEqualToString:@"我的资料"]) {
            [self.menuButton setTitle:@"设置" forState:UIControlStateNormal];
            self.menuButton.titleLabel.font = [UIFont systemFontOfSize:15];
            self.menuButton.tag = 1900002;
        }else{
            [self.menuButton setTitle:@"操作记录" forState:UIControlStateNormal];
            self.menuButton.titleLabel.font = [UIFont systemFontOfSize:13];
            self.menuButton.tag = 1900003;
        }
    }
    self.menuButton.frame = CGRectMake(0, 0, 60, 20);
    self.menuButton.userInteractionEnabled = YES;
    [self.menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithCustomView:self.menuButton];
    self.navigationItem.rightBarButtonItem = right;
}
@end
