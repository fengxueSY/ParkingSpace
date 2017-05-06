//
//  ChooseTypeController.m
//  CheWei
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChooseTypeController.h"
#import "RegisterView.h"
#define BUTTON_title(button_DayI,title) [button_DayI setTitle:title forState:UIControlStateNormal];
@interface ChooseTypeController (){
    UIButton * userButton;
    UIButton * managerButton;
}
@property(nonatomic,assign)NSUInteger userType;/**<用户类型;0,是普通用户.1,是管理员*/
@end

@implementation ChooseTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userType = 0;
    self.title = @"用户的类型";
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.9757 blue:0.8529 alpha:1.0];
    userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(WindowWidth / 8, WindowHeight / 4, WindowWidth * 6 / 8, WindowHeight / 12);
    BUTTON_title(userButton, @"我有车位,我要租车位");
    userButton.titleLabel.font = FONT_size(16);
    userButton.backgroundColor = [UIColor orangeColor];
    [userButton addTarget:self action:@selector(userAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:userButton];
    
    managerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    managerButton.frame = CGRectMake(Min_X(userButton), Max_Y(userButton) + WindowHeight / 60, WindowWidth * 6 / 8, WindowHeight / 12);
    BUTTON_title(managerButton, @"我是车位管理员");
    managerButton.backgroundColor = GRAY_color;
    managerButton.titleLabel.font = FONT_size(16);
    [managerButton addTarget:self action:@selector(managerAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:managerButton];
    
    UIButton * nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(WindowWidth / 16, WindowHeight - barHeight64 - WindowHeight / 12 - tabBarHeight49 / 3, WindowWidth * 14 / 16, WindowHeight / 12);
    BUTTON_title(nextButton, @"下一步");
    nextButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.592 blue:0.8288 alpha:1.0];
    [nextButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:nextButton];
}
#pragma mark -- 选择不同的用户类型
-(void)managerAction:(UIButton *)sender{
    if (_userType == 0) {
        sender.backgroundColor = [UIColor orangeColor];
        userButton.backgroundColor = GRAY_color;
        _userType = 1;
    }
}
-(void)userAction:(UIButton *)sender{
    if (_userType == 1) {
        sender.backgroundColor = [UIColor orangeColor];
        managerButton.backgroundColor = GRAY_color;
        _userType = 0;
    }
}
#pragma mark -- 下一步
-(void)sureAction{
    [RMUniversalAlert showAlertInViewController:self withTitle:@"提示" message:@"选择用户类型注册后不可修改!" cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@[@"重新选择",@"确定"] tapBlock:^(RMUniversalAlert *alert, NSInteger buttonIndex) {
        if (buttonIndex == 3) {
          RegisterView * reVC = [[RegisterView alloc]init];
          reVC.registerCode = 1;
          reVC.type = _userType;
          [self.navigationController pushViewController:reVC animated:YES];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
