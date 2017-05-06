//
//  RegisterView.m
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterView.h"
#import "RegisterView+Helper.h"
#import "CommonAddress.h"
#import <SMS_SDK/SMSSDK.h>
#import "UserMessage.h"
#import "TabBarView.h"
@interface RegisterView ()
@property(nonatomic,strong)NSTimer * timer1;/**<重新获取验证码*/
@property(nonatomic,assign)NSUInteger gender;/**<性别:0是男;1是女;*/
@end

@implementation RegisterView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.6441 green:0.9547 blue:0.9993 alpha:1.0];
     _minCount = 0;
    self.gender = 0;
    [self loadingMyView];
    [self.textButton addTarget:self action:@selector(getTextNumber:) forControlEvents:UIControlEventTouchDown];
    [self.buttonRegister addTarget:self action:@selector(finishMessage:) forControlEvents:UIControlEventTouchDown];
    if (self.registerCode == 1) {
        [self fromRegister];
        [self.boyButton addTarget:self action:@selector(boyAction) forControlEvents:UIControlEventTouchDown];
        [self.girlButton addTarget:self action:@selector(girlAction) forControlEvents:UIControlEventTouchDown];
    }
}
#pragma mark -- 选择性别
-(void)girlAction{
    if (self.gender == 0) {
        self.girlButton.backgroundColor = ORANGE_color;
        self.boyButton.backgroundColor = GRAY_color;
        self.gender = 1;
    }
}
-(void)boyAction{
    if (self.gender == 1) {
        self.boyButton.backgroundColor = ORANGE_color;
        self.girlButton.backgroundColor = GRAY_color;
        self.gender = 0;
    }
}
#pragma mark -- 注册
-(void)beginRegistr{
    [self showHudInView:self.view hint:@"正在注册..."];
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    NSString * url = registerInterface(self.baseInfo.myURL);
//    NSLog(@"%@,%@,%@,%@,%@,%@,%@",self.nameField.text,self.passwordField.text,self.phoneField.text,NSUInteger_String(self.gender),NSUInteger_String(self.type),self.textField.text,self.phoneField0.text);
    NSDictionary * pa = @{@"nickname":self.nameField.text,@"password":self.passwordField.text,@"phoneNumber":self.phoneField.text,@"gender":NSUInteger_String(self.gender),@"role":NSUInteger_String(self.type),@"validateCode":self.textField.text,@"telephone":self.phoneField0.text};
    [manager POST:url parameters:pa progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideHud];
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if (Equarl_stringCode0(Format_String(dic[@"code"]))) {
            [UserMessage saveUserMessage:dic[@"data"]];
            NSNotification * noti = [[NSNotification alloc]initWithName:@"rootViewChange" object:nil userInfo:@{@"code":@"1"}];
            [[NSNotificationCenter defaultCenter] postNotification:noti];

        }else{
        [self showHint:@"注册失败!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
        [self showHint:@"注册失败!"];
    }];
}
#pragma mark -- 找回密码
-(void)getBackPassword{
    [self showHudInView:self.view hint:@"修改中..."];
    AFHTTPSessionManager * manager  =  [AFN_DayI requestWithoutHeader_JSON];
    [manager POST:passwordBackInterface(self.baseInfo.myURL) parameters:@{@"phoneNumber":self.phoneField.text,@"newPassword":self.passwordField.text,@"validateCode":self.textField.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideHud];
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if (Equarl_stringCode0(Format_String(dic[@"code"]))) {
            [self showHint:@"修改成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self showHint:@"修改失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"修改失败"];
        [self hideHud];
    }];
}
#pragma mark -- 完成按钮
-(void)finishMessage:(UIButton *)sender{
    if (self.registerCode == 1) {
        if (self.phoneField.text.length > 0 && self.textField.text.length > 0 && self.passwordField.text.length >= 6 && self.nameField.text > 0 && self.phoneField0.text > 0 ) {
            [self beginRegistr];
        }else{
            if (self.passwordField.text.length < 6) {
                TTAlert1(@"密码需要6位以上!", self);
            }else{
                TTAlert1(@"请完善你的注册信息!", self);
            }
        }
    }else{
       if (self.textField.text.length > 0 && self.passwordField.text.length > 0) {
           [self getBackPassword];
         }else{
           TTAlert1(@"请输入验证码或者密码", self);
         }
    }
}
#pragma mark -- 第三方发送短信
-(void)mobSend{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            [self showHint:@"短信发送成功!" yOffset:2];
        }else{
            [self showHint:@"短信发送失败!"];
        }
    }];
}
#pragma mark -- 验证手机是否注册Http
-(void)verificationPhoneNumber{
    [self showHudInView:self.view hint:@"验证中..."];
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    NSString * url = valicationInterface(self.baseInfo.myURL);
    NSDictionary * dic = @{@"phoneNumber":self.phoneField.text};
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideHud];
        NSDictionary * newDic = [SB_DayI analysisMessage:responseObject];
        NSString * code = Format_String(newDic[@"code"]);
        //没有注册的手机号
        if (Equarl_String(code, @"0")) {
            if (self.registerCode == 1) {
                 [self mobSend];
            }else{
                TTAlert1(@"你的手机号还没注册!", self);
            }
            
        }else if (Equarl_String(code, @"4")){//已经注册的手机号
            if (self.registerCode == 1) {
                TTAlert1(@"手机号已经注册", self);
            }else{
                [self mobSend];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHud];
        [self showHint:@"网络错误,请稍后再试!"];
    }];
}
#pragma mark -- 发送验证码
-(void)getTextNumber:(UIButton *)sender{
    [self.view endEditing:YES];
    if (self.phoneField.text.length == 11) {
        [self sendTextNumber];
    }else{
        TTAlert1(@"请输出正确的手机号码", self);
    }
}
-(void)sendTextNumber{
        if ([self.textButton.currentTitle isEqualToString:@"获取验证码"]) {
           _timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(againNumber) userInfo:nil repeats:YES];
            [self verificationPhoneNumber];
        }else if ([self.textButton.currentTitle isEqualToString:@"重新获取"]){
            [_timer1 setFireDate:[NSDate distantPast]];
            [self mobSend];
        }else{
            //倒数不用处理
        }
}
#pragma mark -- 重新获取验证码
-(void)againNumber{
    _minCount ++;
    if (_minCount == 60) {
        [self.textButton setTitle:@"重新获取" forState:UIControlStateNormal];
        _minCount = 0;
        [_timer1 setFireDate:[NSDate distantFuture]];
    }else{
        NSString * title = [NSString stringWithFormat:@"重新获取:%lu",60 - _minCount];
        [self.textButton setTitle:title forState:UIControlStateNormal];
    }
}
#pragma mark -- textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self changeColor:0];
    [self.view endEditing:YES];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 1311) {
        [self changeColor:1];
    }else if(textField.tag == 1312){
        [self changeColor:2];
    }else if (textField.tag == 1313){
        [self changeColor:3];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
       [self changeColor:0];
       [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated{
    [_timer1 invalidate];//防止时间器的内存泄漏
     _timer1 = nil;
}
@end
