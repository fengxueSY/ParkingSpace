//
//  MonitifyNickname.m
//  CheWei
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MonitifyNickname.h"

@interface MonitifyNickname ()

@end

@implementation MonitifyNickname

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = WHITE_color;
    L1(self.fromType);
    self.nickNameFiled = [[UITextField alloc]init];
    self.nickNameFiled.frame = CGRectMake(WindowWidth / 16, WindowHeight / 14, WindowWidth * 14 / 16, WindowHeight / 14);
    self.nickNameFiled.delegate = self;
    if (Equarl_String(self.fromType, @"1")) {
        self.nickNameFiled.text = self.baseInfo.myNickName;
    }
    if (Equarl_String(self.fromType, @"2")) {
        self.nickNameFiled.text = self.baseInfo.myTelephone;
    }
    if (Equarl_String(self.fromType, @"3")) {
        self.nickNameFiled.text = @"车牌号码";
    }

    self.nickNameFiled.returnKeyType = UIReturnKeyDone;
    self.nickNameFiled.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.nickNameFiled];

    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0,0, 40, 20);
    [button1 setTitle:@"完成" forState:UIControlStateNormal];
    [button1 setTitleColor:BLACK_color forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(done1) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = item;

    // Do any additional setup after loading the view.
}
-(void)done1{
    if (self.nickNameFiled.text.length > 0) {
        [self showHudInView:self.view hint:@"修改中..."];
        if (Equarl_String(self.fromType, @"1")) {
            NSDictionary * pa = @{@"uid":self.baseInfo.myUid,@"nickname":self.nickNameFiled.text};
            [self changeMessage:updateNicknameInterface(self.baseInfo.myURL) AndDic:pa];
        }
        if (Equarl_String(self.fromType, @"2")) {
            NSDictionary * pa = @{@"uid":self.baseInfo.myUid,@"telephone":self.nickNameFiled.text};
            [self changeMessage:updateTelephoneInterface(self.baseInfo.myURL) AndDic:pa];
        }
        if (Equarl_String(self.fromType, @"3")) {
            NSDictionary * pa = @{@"uid":self.baseInfo.myUid,@"plate":self.nickNameFiled.text};
            [self changeMessage:updatePlateInterface(self.baseInfo.myURL) AndDic:pa];
        }

    }else{
        TTAlert1(@"请填写修改的内容!", self);
    }
    
}
#pragma mark -- 修改不同的内容
-(void)changeMessage:(NSString *)url AndDic:(NSDictionary *)pa{
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:self.baseInfo.myToken];
    [manager POST:url parameters:pa progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
//        L1(dic);
        if (Equarl_stringCode0(Format_String(dic[@"code"]))) {
            [self showHint:@"修改成功!"];
            [NSU_DayI defaultsSave:@"2" withKey:CHANGE_ME];
            if (Equarl_String(self.fromType, @"1")) {
                 self.baseInfo.myNickName = self.nickNameFiled.text;
                [NSU_DayI defaultsSave:self.baseInfo.myNickName withKey:NICKNAME];
            }
            if (Equarl_String(self.fromType, @"2")) {
                self.baseInfo.myTelephone = self.nickNameFiled.text ;
                [NSU_DayI defaultsSave:self.baseInfo.myTelephone withKey:TELEPHONR];
            }
            if (Equarl_String(self.fromType, @"3")) {
                self.nickNameFiled.text = @"车牌号码";
            }

        }else{
            TTAlert1(Format_String(dic[@"message"]), self);
        }
        [self hideHud];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //            L1(error);
        [self hideHud];
        TTAlert1(@"修改失败!", self);

    }];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
