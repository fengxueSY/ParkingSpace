//
//  LoginView.m
//  CheWei
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginView.h"
#import "LoginView+Hepler.h"
#import "RegisterView.h"
#import "TabBarView.h"
#import "UIView+Shake.h"
#import "JPUSHService.h"
#import "ChooseTypeController.h"
#import "UserMessage.h"
@interface LoginView ()
@property(nonatomic,strong)UserInfo * info;
@end

@implementation LoginView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.navigationItem.backBarButtonItem = BackTitle_hidden;
    self.view.backgroundColor = [UIColor colorWithRed:0.1003 green:0.6254 blue:0.9997 alpha:1.0];
    _info = Info_INIT;
    [self phoneNumberAndPassword];
    [self loginAndRegister];
    [self.LoginButton addTarget:self action:@selector(LoginAction) forControlEvents:UIControlEventTouchDown];
    [self.RegisterButton addTarget:self action:@selector(RegisterAction) forControlEvents:UIControlEventTouchDown];
    [self.sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchDown];
//    NSSet * set2 = [[NSSet alloc]initWithObjects:@"深圳", nil];
    [JPUSHService setTags:nil alias:@"zhuyun" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"irescode%d,nsset%@,ial%@",iResCode,iTags,iAlias);
    }];
}
-(void)viewDidAppear:(BOOL)animated{
//    self.baseInfo.myPhoneNumber = [NSU_DayI defaultsRead:TELEPHONR];
//    if (self.baseInfo.myPhoneNumber != nil) {
//            TabBarView * tabVC = [[TabBarView alloc]init];
//            UINavigationController * na = [[UINavigationController alloc]initWithRootViewController:tabVC];
//           [self.navigationController presentViewController:na animated:YES completion:nil];
//    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.phoneFiled == textField) {
        self.phoneView.layer.borderColor = [[UIColor orangeColor] CGColor];
        self.passwordView.layer.borderColor = [[UIColor colorWithRed:0.8036 green:0.7163 blue:1.0 alpha:1.0] CGColor];
    }else{
        self.passwordView.layer.borderColor = [[UIColor orangeColor] CGColor];
        self.phoneView.layer.borderColor = [[UIColor colorWithRed:0.8036 green:0.7163 blue:1.0 alpha:1.0] CGColor];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self keboardHide];
    return YES;
}
#pragma mark -- 注册
-(void)LoginAction{
    ChooseTypeController * chooseType = [[ChooseTypeController alloc]init];
    [self.navigationController pushViewController:chooseType animated:YES];
}
#pragma mark -- 找回密码
-(void)RegisterAction{
      RegisterView * registerVC = [[RegisterView alloc]init];
      registerVC.registerCode = 2;
      [self.navigationController pushViewController:registerVC animated:YES];
}
#pragma mark -- 登录
-(void)sureAction{
//    self.phoneFiled.text = @"18627277061";
//    self.phoneFiled.text = @"18236592359";
//    self.passwordFiled.text = @"123456";
    if (self.passwordFiled.text.length > 0 && self.phoneFiled.text.length > 0) {
        [self showHudInView:self.view hint:@"登录中..."];
        AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
        [manager POST:loginInterface(self.baseInfo.myURL) parameters:@{@"phoneNumber":self.phoneFiled.text,@"password":self.passwordFiled.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self hideHud];
            NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
//            L1(dic);
            if (Equarl_stringCode0(Format_String(dic[@"code"]))) {
                [UserMessage saveUserMessage:dic[@"data"]];
                NSNotification * noti = [[NSNotification alloc]initWithName:@"rootViewChange" object:nil userInfo:@{@"code":@"1"}];
                [[NSNotificationCenter defaultCenter] postNotification:noti];
            }else{
                [self showHint:Format_String(dic[@"message"])];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self hideHud];
            [self showHint:@"登录失败"];
        }];
    }else{
        if (self.phoneFiled.text.length == 0) {
            [self.view shakeLeftAndRight:self.phoneView];
        }
        if (self.passwordFiled.text.length == 0) {
            [self.view shakeLeftAndRight:self.passwordView];
        }
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self keboardHide];
//    NSDictionary * myMessage = @{@"platform": @"all",
//                                  @"audience": @{
//                                          @"alias": @[
//                                                  @"zhuyun"
//                                                  ]
//                                          },
//                                  @"notification": @{
//                                          @"ios": @{
//                                                  @"alert": @"Hi, JPush!",
//                                                  @"sound": @"default",
//                                                  @"badge": @"+1",
//                                                  @"extras":@{
//                                                          @"newsid": @"321"
//                                                          }
//                                                  }
//                                          },
//                                  };
//
//    [self showHudInView:self.view hint:@"登陆中..."];
//    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:nil];
//    NSString * url1 = @"https://api.jpush.cn/v3/push";
//    [manager POST:url1 parameters:myMessage progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
//        NSLog(@"dic= %@",dic);
//        [self hideHud];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error = %@",error);
//        [self hideHud];
//        
//    }];

}
-(void)keboardHide{
    [self.phoneFiled resignFirstResponder];
    [self.passwordFiled resignFirstResponder];
    self.phoneView.layer.borderColor = [[UIColor colorWithRed:0.8036 green:0.7163 blue:1.0 alpha:1.0] CGColor];
    self.passwordView.layer.borderColor = [[UIColor colorWithRed:0.8036 green:0.7163 blue:1.0 alpha:1.0] CGColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
