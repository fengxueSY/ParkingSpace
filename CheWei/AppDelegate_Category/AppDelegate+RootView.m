//
//  AppDelegate+RootView.m
//  CheWei
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate+RootView.h"
#import "LoginView.h"
#import "RegisterView.h"
#import "CommonAddress.h"
#import "TabBarView.h"
#import "UserMessage.h"
@implementation AppDelegate (RootView)
-(void)setRootView{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRootView:) name:@"rootViewChange" object:nil];
    
    [UserMessage readUserMessage];
    //判断自动登陆
    if (self.info.myPhoneNumber != nil) {
        [self mainView];
    }else{
        [self loginView];
    }
}
-(void)changeRootView:(NSNotification *)sender{
    NSString * code = sender.userInfo[@"code"];
    if (Equarl_String(code, @"1")) {
        [self mainView];
    }
    if (Equarl_String(code, @"2")) {
        [self loginView];
    }
}
#pragma mark -- 登录界面
-(void)loginView{
    LoginView * viewVC = [[LoginView alloc]init];
    UINavigationController * LoginNA = [[UINavigationController alloc]initWithRootViewController:viewVC];
    self.window.rootViewController = LoginNA;
}
#pragma mark -- 主界面
-(void)mainView{
    TabBarView * tabVC = [[TabBarView alloc]init];
    UINavigationController * na = [[UINavigationController alloc]initWithRootViewController:tabVC];
    self.window.rootViewController = na;
}
@end
