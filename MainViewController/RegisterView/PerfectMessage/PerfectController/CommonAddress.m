//
//  CommonAddress.m
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CommonAddress.h"
#import "CommonAddress+Help.h"
#import "TabBarView.h"
@interface CommonAddress ()
@property(nonatomic,assign)NSUInteger gender;/**<性别:0是男;1是女;*/
@end

@implementation CommonAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善资料";
    self.view.backgroundColor = [UIColor colorWithRed:0.6912 green:0.9368 blue:0.984 alpha:1.0];
    self.code = 1;
    self.gender = 0;
    [self loadCommonAddressView];
    [self.skipButton addTarget:self action:@selector(loginIN) forControlEvents:UIControlEventTouchDown];
    [self.confirmButton addTarget:self action:@selector(submitAddress) forControlEvents:UIControlEventTouchDown];
    [self.boyButton addTarget:self action:@selector(boyAction) forControlEvents:UIControlEventTouchDown];
    [self.girlButton addTarget:self action:@selector(girlAction) forControlEvents:UIControlEventTouchDown];
    self.phoneField.text = self.phoneNumber;
    NSLog(@"%@,%@,%@,%@,",self.phoneNumber,self.password,self.typeUser,self.textNumber);
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
#pragma mark -- 跳转主界面,需要回到登录界面
-(void)viewWillAppear:(BOOL)animated{
    if (self.code == 2) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
#pragma mark -- 提交注册
/**
 *  参数:1.昵称nickname,2.用户密码password,3.注册手机号phoneNumber,4.性别gender,5.用户类型role,6.验证码validateCode,7.联系手机号telephone
 */
-(void)submitAddress{
    if (self.phoneField.text.length != 11) {
        self.phoneField.text = self.phoneNumber;
    }
    if (self.nameField.text.length > 0) {
        [self showHudInView:self.view hint:@"正在注册..."];
        AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
        NSString * url = Stitch_String(self.baseInfo.myURL, @"/api/user");
        NSDictionary * pa = @{@"nickname":self.nameField.text,@"password":self.password,@"phoneNumber":self.phoneNumber,@"gender":NSUInteger_String(self.gender),@"role":self.typeUser,@"validateCode":self.textNumber,@"telephone":self.phoneField.text};
        L2(url, pa);
        [manager POST:url parameters:pa progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self hideHud];
            NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
            L1(dic);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            L1(error);
            [self hideHud];
        }];

    }else{
        TTAlert1(@"请填写你的昵称", self);
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nameField resignFirstResponder];
    [self.phoneField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameField resignFirstResponder];
    [self.phoneField resignFirstResponder];
}
#pragma mark -- 先跳过
-(void)loginIN{
    TabBarView * tabVC = [[TabBarView alloc]init];
    UINavigationController * na = [[UINavigationController alloc]initWithRootViewController:tabVC];
    self.code = 2;
    [self.navigationController presentViewController:na animated:YES completion:nil];
}

#pragma mark -- table delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cells = @"cells";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cells];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cells];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"常用地址%lu",(long)indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return WindowHeight / 10;
}
#pragma mark -- 设置cell的画线靠左
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
-(void)viewDidLayoutSubviews {
    if ([self.addressTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.addressTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.addressTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.addressTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
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
