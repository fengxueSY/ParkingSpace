//
//  RegisterView+Helper.m
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterView+Helper.h"

@implementation RegisterView (Helper)
-(void)loadingMyView{
    for (int i = 0; i < 3; i ++) {
        UIView * view = [[UIView alloc]init];
        view.tag = i + 311;
        view.backgroundColor = [UIColor clearColor];
        view.layer.cornerRadius = 5;
        view.layer.borderColor = [[UIColor colorWithRed:0.8036 green:0.7163 blue:1.0 alpha:1.0] CGColor];
        view.layer.borderWidth = 0.7;
        view.frame = CGRectMake(WindowWidth / 8 - WindowWidth / 32, WindowHeight / 15 + (WindowHeight / 15 + WindowHeight / 60) * i, WindowWidth * 3 / 4 + WindowWidth / 16, WindowHeight / 15);
        if (i == 0) {
            view.frame = CGRectMake(WindowWidth / 8 - WindowWidth / 32, WindowHeight / 15 + (WindowHeight / 15 + WindowHeight / 60) * i, WindowWidth * 2 / 4, WindowHeight / 15);
            self.textButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.textButton.frame = CGRectMake(CGRectGetMaxX(view.frame) - 5, CGRectGetMinY(view.frame), WindowWidth / 4 + WindowWidth / 16 + 5, WindowHeight / 15);
            [self.textButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.textButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            self.textButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.6102 blue:0.5864 alpha:1.0];
            self.textButton.layer.cornerRadius = 3;
            
        }
        [self.view addSubview:view];
        
        UITextField * filed = [[UITextField alloc]init];
        filed.tag = 1000 + view.tag;
        filed.frame = view.frame;
        filed.delegate = self;
        filed.returnKeyType = UIReturnKeyDone;
        filed.clearButtonMode = UITextFieldViewModeAlways;
        filed.backgroundColor = [UIColor clearColor];
        if (i == 0) {
            filed.placeholder = @" 请输入手机号";
            self.phoneField = filed;
        }else if (i == 1){
            filed.placeholder = @" 请输入4位验证码";
            self.textField = filed;
        }else if (i == 2){
            filed.placeholder = @" 请输入密码(6位以上)";
            self.passwordField = filed;
        }
        [self.view addSubview:filed];
        [self.view addSubview:self.textButton];
    }
    self.buttonRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.registerCode == 1) {
        [self.buttonRegister setTitle:@"注册" forState:UIControlStateNormal];
        self.title = @"注册";
    }else{
        [self.buttonRegister setTitle:@"确认" forState:UIControlStateNormal];
        self.title = @"找回密码";
    }
    self.buttonRegister.frame = CGRectMake(WindowWidth / 16, WindowHeight - WindowHeight / 12 - 64 - WindowWidth / 16, WindowWidth * 14 / 16, WindowHeight / 12);
    self.buttonRegister.backgroundColor = [UIColor colorWithRed:0.9141 green:0.4825 blue:1.0 alpha:1.0];
    self.buttonRegister.layer.cornerRadius = 2;
    self.buttonRegister.titleLabel.font = FONT_size(20);
    [self.view addSubview:self.buttonRegister];

}
-(void)fromRegister{
    float leftWide = WindowWidth / 8 - WindowWidth  / 32;
    UIView * backView = [[UIView alloc]init];
    backView.frame = CGRectMake(leftWide, Max_Y(self.passwordField) + WindowHeight / 60, WindowWidth * 6 / 8, WindowHeight / 14);
    backView.backgroundColor = WHITE_color;
    [self.view addSubview:backView];
    
    UILabel * label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(leftWide, Max_Y(self.passwordField) + WindowHeight / 60, WindowWidth / 8, WindowHeight / 14);
    label1.text = @" 姓名:";
    label1.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label1];
    
    self.nameField = [[UITextField alloc]init];
    self.nameField.frame = CGRectMake(Max_X(label1), Min_Y(label1), WindowWidth * 5 / 8, WindowHeight / 14);
    self.nameField.placeholder = @" 默认所有订单的联系人";
    self.nameField.font = FONT_size(16);
    self.nameField.returnKeyType = UIReturnKeyDone;
    self.nameField.delegate = self;
    self.nameField.tag = 1314;
    [self.view addSubview:self.nameField];
    
    
    UIView * view2 = [[UIView alloc]init];
    view2.frame = CGRectMake(leftWide, Max_Y(backView) + WindowHeight / 60, WindowWidth * 6 / 8, WindowHeight / 14);
    view2.backgroundColor = WHITE_color;
    [self.view addSubview:view2];
    
    UILabel * label2 = [[UILabel alloc]init];
    label2.frame = CGRectMake(leftWide, Min_Y(view2), WindowWidth / 4, WindowHeight / 14);
    label2.text = @" 手机联系人:";
    label2.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label2];
    
    self.phoneField0 = [[UITextField alloc]init];
    self.phoneField0.delegate = self;
    self.phoneField0.frame = CGRectMake(Max_X(label2), Min_Y(label2), WindowWidth * 4 / 8, WindowHeight / 14);
    self.phoneField0.placeholder = @" 默认联系方式";
    self.phoneField0.font = FONT_size(16);
    self.phoneField0.returnKeyType = UIReturnKeyDone;
    self.phoneField0.tag = 1315;
    [self.view addSubview:self.phoneField0];
    
    self.boyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.boyButton.frame = CGRectMake(leftWide + WindowWidth / 64, Max_Y(view2) + WindowHeight / 60, WindowWidth * 3 / 16 + WindowWidth * 5 / 32, WindowHeight / 18);
    self.boyButton.backgroundColor = ORANGE_color;
    [self.boyButton setTitle:@"先生" forState:UIControlStateNormal];
    self.boyButton.layer.cornerRadius = 8;
    self.boyButton.titleLabel.font = FONT_size(17);
    [self.view addSubview:self.boyButton];
    
    self.girlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.girlButton.frame = CGRectMake(Max_X(self.boyButton) + WindowWidth / 32,Min_Y(self.boyButton), WindowWidth * 3 / 16 + + WindowWidth * 5 / 32, WindowHeight / 18);
    self.girlButton.backgroundColor = GRAY_color;
    [self.girlButton setTitle:@"女士" forState:UIControlStateNormal];
    self.girlButton.titleLabel.font = FONT_size(17);
    self.girlButton.layer.cornerRadius = 8;
    [self.view addSubview:self.girlButton];
}
-(void)changeColor:(NSUInteger)sender{
    UIView * view1 = (UIView *)[self.view viewWithTag:311];
    UIView * view2 = (UIView *)[self.view viewWithTag:312];
    UIView * view3 = (UIView *)[self.view viewWithTag:313];
    view1.layer.borderColor = [[UIColor colorWithRed:0.8036 green:0.7163 blue:1.0 alpha:1.0] CGColor];
    view2.layer.borderColor = [[UIColor colorWithRed:0.8036 green:0.7163 blue:1.0 alpha:1.0] CGColor];
    view3.layer.borderColor = [[UIColor colorWithRed:0.8036 green:0.7163 blue:1.0 alpha:1.0] CGColor];
    if (sender == 1) {
        view1.layer.borderColor = [[UIColor orangeColor] CGColor];
    }
    if (sender == 2) {
        view2.layer.borderColor = [[UIColor orangeColor] CGColor];
    }
    if (sender == 3) {
        view3.layer.borderColor = [[UIColor orangeColor] CGColor];
    }
    
}
@end
