//
//  LoginView+Hepler.m
//  CheWei
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginView+Hepler.h"

@implementation LoginView (Hepler)
-(void)phoneNumberAndPassword{
    self.phoneView = [[UIView alloc]init];
    self.phoneView.frame = CGRectMake(WindowWidth / 8, WindowHeight / 5, WindowWidth * 6 / 8,WindowHeight / 15);
    self.phoneView.backgroundColor = WHITE_color;
    self.phoneView.layer.cornerRadius = 6;
//    self.phoneView.layer.borderColor = [[UIColor colorWithRed:0.8036 green:0.7163 blue:1.0 alpha:1.0] CGColor];
//    self.phoneView.layer.borderWidth = 0.7;
    [self.view addSubview:self.phoneView];
    
    self.phoneFiled = [[UITextField alloc]init];
    self.phoneFiled.frame = self.phoneView.frame;
    self.phoneFiled.placeholder = @"  请输入手机号!";
    self.phoneFiled.delegate = self;
    self.phoneFiled.returnKeyType = UIReturnKeyDone;
    self.phoneFiled.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneFiled.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.phoneFiled];
    
    self.passwordView = [[UIView alloc]init];
    self.passwordView.frame = CGRectMake(WindowWidth / 8,Max_Y(self.phoneView) + WindowHeight / 60, WindowWidth * 6 / 8,WindowHeight / 15);
    self.passwordView.backgroundColor = WHITE_color;
    self.passwordView.layer.cornerRadius = 6;
//    self.passwordView.layer.borderColor = [[UIColor colorWithRed:0.8036 green:0.7163 blue:1.0 alpha:1.0] CGColor];
//    self.passwordView.layer.borderWidth = 0.7;
    [self.view addSubview:self.passwordView];

    self.passwordFiled = [[UITextField alloc]init];
    self.passwordFiled.frame = self.passwordView.frame;
    self.passwordFiled.placeholder = @"  请输入密码!";
    self.passwordFiled.delegate = self;
    self.passwordFiled.returnKeyType = UIReturnKeyDone;
    self.passwordFiled.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordFiled.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.passwordFiled];
}
-(void)loginAndRegister{
    float buttonHight = WindowHeight / 24;
    float buttonWide = WindowWidth * 10 / 32;
    self.LoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.LoginButton.frame = CGRectMake(Min_X(self.passwordView),Max_Y(self.passwordView) + WindowHeight / 30, buttonWide, buttonHight);
    [self.LoginButton setTitle:@"注册账号" forState:UIControlStateNormal];
    [self.LoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.LoginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.LoginButton.backgroundColor = WHITE_color;
    self.LoginButton.layer.cornerRadius = 1;
    [self.view addSubview:self.LoginButton];
    
    self.RegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.RegisterButton.frame = CGRectMake(Max_X(self.LoginButton) + WindowWidth / 8,Min_Y(self.LoginButton), buttonWide, buttonHight);
    [self.RegisterButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.RegisterButton setTitleColor:BLACK_color forState:UIControlStateNormal];
    self.RegisterButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.RegisterButton.backgroundColor = WHITE_color;
    self.RegisterButton.layer.cornerRadius = 1;
    [self.view addSubview:self.RegisterButton];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureButton.frame = CGRectMake(WindowWidth / 16, WindowHeight - barHeight64 - WindowWidth / 16 - WindowHeight / 12, WindowWidth * 14 / 16, WindowHeight / 13);
    [self.sureButton setTitle:@"登录" forState:UIControlStateNormal];
    self.sureButton.backgroundColor = WHITE_color;
    [self.sureButton setTitleColor:BLACK_color forState:UIControlStateNormal];
    self.sureButton.layer.cornerRadius = 4;
    self.sureButton.titleLabel.font = FONT_size(20);
    [self.view addSubview:self.sureButton];
}

@end
