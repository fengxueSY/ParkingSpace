//
//  BindPhoneNumber.m
//  CheWei
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BindPhoneNumber.h"
#import <SMS_SDK/SMSSDK.h>
@interface BindPhoneNumber ()
@property(nonatomic,strong)NSTimer * timer2;/**<重新获取验证码*/
@property(nonatomic)NSUInteger minCount1;/**<默认倒数时间*/
@end

@implementation BindPhoneNumber

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改绑定手机号";
    self.view.backgroundColor = WHITE_color;
    self.minCount1 = 0;
    for (int i = 0; i < 3; i ++) {
        UITextField * filed = [[UITextField alloc]init];
        filed.frame =  CGRectMake(WindowWidth / 8 - WindowWidth / 32, WindowHeight / 15 + (WindowHeight / 15 + WindowHeight / 60) * i, WindowWidth * 3 / 4 + WindowWidth / 16, WindowHeight / 15);
        if (i == 0) {
            filed.frame = CGRectMake(WindowWidth / 8 - WindowWidth / 32, WindowHeight / 15 + (WindowHeight / 15 + WindowHeight / 60) * i, WindowWidth * 2 / 4, WindowHeight / 15);
            self.textButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.textButton.frame = CGRectMake(CGRectGetMaxX(filed.frame) - 5, CGRectGetMinY(filed.frame), WindowWidth / 4 + WindowWidth / 16 + 5, WindowHeight / 15);
            [self.textButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.textButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            self.textButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.6102 blue:0.5864 alpha:1.0];
            self.textButton.layer.cornerRadius = 3;
            
        }
        filed.delegate = self;
        filed.returnKeyType = UIReturnKeyDone;
        filed.clearButtonMode = UITextFieldViewModeAlways;
        filed.backgroundColor = [UIColor lightGrayColor];
        if (i == 0) {
            filed.placeholder = @" 新的手机号";
            self.phoneNumberNew = filed;
        }else if (i == 1){
            filed.placeholder = @" 请输入4位验证码";
            self.textFiled = filed;
        }else if (i == 2){
            filed.placeholder = @" 请输入当前密码";
            self.passwordFiled = filed;
        }
        [self.view addSubview:filed];
        [self.view addSubview:self.textButton];
    }
    [self.textButton addTarget:self action:@selector(textAction) forControlEvents:UIControlEventTouchDown];
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0,0, 40, 20);
    [button1 setTitle:@"完成" forState:UIControlStateNormal];
    [button1 setTitleColor:BLACK_color forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = item;

}
-(void)done{
    if (self.passwordFiled.text.length > 0 && self.phoneNumberNew.text.length > 0 && self.textFiled.text.length > 0) {
        [self showHudInView:self.view hint:@"修改中..."];
         AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:self.baseInfo.myToken];
         NSDictionary * dic = @{@"uid":self.baseInfo.myUid,@"phoneNumber":self.phoneNumberNew.text,@"password":self.passwordFiled.text,@"validateCode":self.textFiled.text};
         [manager POST:bindPhoneNumberInterface(self.baseInfo.myURL) parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSDictionary * message = [SB_DayI analysisMessage:responseObject];
             L1(message);
             [self hideHud];
             if (Equarl_stringCode0(Format_String(message[@"code"]))) {
                 [self showHint:@"修改绑定手机号成功"];
                 [NSU_DayI defaultsSave:self.phoneNumberNew.text withKey:PHONENUMBER];
                 [NSU_DayI defaultsSave:@"2" withKey:CHANGE_ME];
                 [self.navigationController popToRootViewControllerAnimated:YES];
             }else{
                 TTAlert1(Format_String(message[@"message"]), self);
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             L1(error);
             [self hideHud];
             [self showHint:@"修改失败!"];
         }];
       }else{
        TTAlert1(@"请填写必要的信息!", self);
      }
}
#pragma mark -- 发送验证码
-(void)textAction{
    [self.view endEditing:YES];
    if (self.phoneNumberNew.text.length == 11) {
        if ([self.textButton.currentTitle isEqualToString:@"获取验证码"]) {
            [self sendNumber];
            _timer2 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(againNumber2) userInfo:nil repeats:YES];
        }else if ([self.textButton.currentTitle isEqualToString:@"重新获取"]){
            [_timer2 setFireDate:[NSDate distantPast]];
            [self sendNumber];
        }else{
            //倒数不用处理
        }
    }else{
        TTAlert1(@"请填写正确的手机号!", self);
    }
}
-(void)againNumber2{
    _minCount1 ++;
    if (_minCount1 == 60) {
        [self.textButton setTitle:@"重新获取" forState:UIControlStateNormal];
        _minCount1 = 0;
        [_timer2 setFireDate:[NSDate distantFuture]];
    }else{
        NSString * title = [NSString stringWithFormat:@"重新获取:%lu",60 - _minCount1];
        [self.textButton setTitle:title forState:UIControlStateNormal];
    }

}
-(void)sendNumber{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberNew.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            [self showHint:@"短信发送成功!" yOffset:2];
        }else{
            [self showHint:@"短信发送失败!"];
        }
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
        [_timer2 invalidate];
         _timer2 = nil;
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
