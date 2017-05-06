//
//  UpdatePassword.m
//  CheWei
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UpdatePassword.h"

@interface UpdatePassword ()

@end

@implementation UpdatePassword

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"修改密码";
     self.view.backgroundColor = WHITE_color;
    
    self.passwordOld = [[UITextField alloc]init];
    self.passwordOld.frame = CGRectMake(WindowWidth / 16, WindowHeight / 10, WindowWidth * 14 / 16, WindowHeight / 14);
    self.passwordOld.delegate = self;
    self.passwordOld.placeholder = @"旧密码";
    self.passwordOld.returnKeyType = UIReturnKeyDone;
    self.passwordOld.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.passwordOld];
    
    self.passwordNew = [[UITextField alloc]init];
    self.passwordNew.frame = CGRectMake(WindowWidth / 16,Max_Y(self.passwordOld) + WindowHeight / 50, WindowWidth * 14 / 16, WindowHeight / 14);
    self.passwordNew.delegate = self;
    self.passwordNew.placeholder = @"新密码";
    self.passwordNew.returnKeyType = UIReturnKeyDone;
    self.passwordNew.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.passwordNew];
    
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0,0, 40, 20);
    [button1 setTitle:@"完成" forState:UIControlStateNormal];
    [button1 setTitleColor:BLACK_color forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = item;
}
#pragma mark -- 修改密码
-(void)done{
    if (self.passwordOld.text.length > 0 && self.passwordNew.text.length > 0) {
        [self showHudInView:self.view hint:@"修改中..."];
        AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:self.baseInfo.myToken];
        NSDictionary * dic = @{@"uid":self.baseInfo.myUid,@"oldPassword":self.passwordOld.text,@"newPassword":self.passwordNew.text};
        [manager POST:updatePasswordInterface(self.baseInfo.myURL) parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self hideHud];
            NSDictionary * message = [SB_DayI analysisMessage:responseObject];
            if (Equarl_stringCode0(Format_String(message[@"code"]))) {
                [self showHint:@"密码修改成功!"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                TTAlert1(Format_String(message[@"message"]), self);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self hideHud];
            TTAlert1(@"修改失败", self);
        }];
    }else{
        TTAlert1(@"请输入旧密码和新密码!", self);
    }
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
