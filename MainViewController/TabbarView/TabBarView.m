//
//  TabBarView.m
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TabBarView.h"
#import "TabBarView+views.h"
#import "TabBarView+parkMessage.h"
#import "SearchResultController.h"
#import "ConfirmRentController.h"
#import "SearchRecordController.h"
#import "MyRentParkController.h"
#import "RecordController.h"
#import "NewsView.h"
#import "MenuView.h"
#import "LoginView.h"
#import "SettingView.h"
#define NEWS_TITLE @"消息"
#define ORDER_TITLE @"订单"
#define MESSAGE_TITLE @"我的"
@interface TabBarView (){
    NSString * buttonStr;
    NSMutableDictionary * messageDic;
    UIButton * backButton;
    NSMutableDictionary * payDic;
}
@end

@implementation TabBarView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMyView];
    [self baseButtons];
    [self.newsButton addTarget:self action:@selector(newsFrom) forControlEvents:UIControlEventTouchDown];
    [self.menuButton addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(menuButtonNotification:) name:@"menuButtonNotificationTitle" object:nil];
    //收到消息的测试
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showParkingView:) name:@"searchParkBasisNeedSuccessd" object:nil];
    self.newsButton.hidden = YES;
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 1){
        self.title = @"消息";
        self.menuButton.hidden = YES;
    }else if (item.tag == 2){
        self.title = @"订单信息";
        self.menuButton.hidden = YES;
    }else if (item.tag == 3){
        if (Equarl_String(Format_String(self.info.myRole), @"0")) {
            self.title = @"租放";
        }else{
            self.title = @"扫码";
        }
        self.menuButton.hidden = NO;
    }else if (item.tag == 4){
        self.title = @"我的资料";
        [self.menuButton setTitle:@"设置" forState:UIControlStateNormal];
        self.menuButton.titleLabel.font = FONT_size(15);
        self.menuButton.tag = 1900002;
        self.menuButton.hidden = NO;
    }
}

#pragma mark -- 消息和菜单
-(void)newsFrom{
    NewsView * vc1 = [[NewsView alloc]init];
    [self.navigationController pushViewController:vc1 animated:YES];
}
#pragma mark -- 抢单成功，要弹出的界面
-(void)showParkingView:(NSNotification *)fication{
    messageDic = [[NSMutableDictionary alloc]initWithDictionary:fication.userInfo];
    [self creatParkMessageView:fication.userInfo];
}
#pragma mark -- 对收到推送消息界面的处理  删除该界面
-(void)deleteParkMessageView{
    [self.parkMessageView removeFromSuperview];
}
#pragma mark -- 对收到推送消息界面的处理  确认租赁
-(void)confirmButtonParkAddress{
    if (backButton) {
        [backButton removeFromSuperview];
    }
    if (self.parkMessageView) {
        [self.parkMessageView removeFromSuperview];
    }
    backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
    backButton.backgroundColor = [UIColor grayColor];
    backButton.alpha = 0.7;
    backButton.userInteractionEnabled = YES;
    [self.view addSubview:backButton];
    [self creatParkTrade];
}
-(void)creatParkTrade{
    NSArray * array = [messageDic objectForKey:@"data"];
    NSDictionary * dicOld = array[0];
    NSDictionary * urlDic = @{@"uid":_info.myUid,@"orderId":[dicOld objectForKey:@"orderId"],@"parkStart":[dicOld objectForKey:@"parkStart"],@"parkEnd":[dicOld objectForKey:@"parkEnd"]};
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:_info.myToken];
    [manager POST:[NSString creatParkingTradeHttpsUrl:_info.myURL] parameters:urlDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary * dataDic = [dic objectForKey:@"data"];
            payDic = [[NSMutableDictionary alloc]initWithDictionary:dataDic];
            [self resultWindow:dataDic];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:@"menuButtonNotificationTitle"];
}
-(void)moneyButtonForPayBar{
    [backButton removeFromSuperview];
    [self.windowView removeFromSuperview];
    ConfirmRentController * con = [[ConfirmRentController alloc]init];
    con.payDic = payDic;
    [self.navigationController pushViewController:con animated:YES];
}
#pragma mark -- 对收到推送消息界面的处理  查看详情
-(void)detailsButtonParkMessage{
    [self.parkMessageView removeFromSuperview];
    SearchResultController * result = [[SearchResultController alloc]init];
    result.dataDic = [[NSDictionary alloc]initWithDictionary:messageDic];
    [self.navigationController pushViewController:result animated:YES];
}
#pragma mark -- 对收到推送消息界面的处理  下一个
-(void)nextButtonParkMessage{
    NSLog(@"下一个");
    [self.windowView removeFromSuperview];
    [self.parkMessageView removeFromSuperview];
    NSArray * array = [messageDic objectForKey:@"data"];
    NSDictionary * dicOld = array[0];
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:_info.myToken];
    [manager GET:[NSString nextParkingReqId:[dicOld objectForKey:@"reqId"] httpsUrl:_info.myURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        NSLog(@"dic == %@  %@",dic,[dic objectForKey:@"message"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)menuButtonNotification:(NSNotification *)sender{
    NSDictionary * dic = [sender userInfo];
    buttonStr = [dic objectForKey:@"title"];
    [self changeButtonTitle:[dic objectForKey:@"title"]];
}
-(void)menuAction:(UIButton *)sender{
    if (sender.tag == 1900001) {
        //跳转到我租放的车位界面
        MyRentParkController * rent = [[MyRentParkController alloc]init];
        [self.navigationController pushViewController:rent animated:YES];
    }
    if (sender.tag == 1900000) {
        //跳转到查找记录界面
        SearchRecordController * search = [[SearchRecordController alloc]init];
        [self.navigationController pushViewController:search animated:YES];
    }
    if (sender.tag == 1900002) {
        RecordController * rec = [[RecordController alloc]init];
        [self.navigationController pushViewController:rec animated:YES];
    }

//    if (sender.tag == 1900000) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"跳转到记录界面" object:self userInfo:@{@"senderTag":@"1900000"}];
//    }
//    if (sender.tag == 1900001){
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"跳转到记录界面" object:self userInfo:@{@"senderTag":@"1900001"}];
//    }
//    if (sender.tag == 1900002) {
//        SettingView * set = [[SettingView alloc]init];
//        [self.navigationController pushViewController:set animated:YES];
//    }
//    if (sender.tag == 1900003) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"跳转到记录界面" object:self userInfo:@{@"senderTag":@"1900002"}];
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
