//
//  SearchResultController.m
//  CheWei
//
//  Created by shenyang on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchResultController.h"
#import "SearchResultController+creatUI.h"
#import "SearchResultCell.h"
#import "ConfirmRentController.h"
#import "MapAddressController.h"

@interface SearchResultController (){
    NSArray * imgArray;
    UIButton * backViewButton;
    NSMutableDictionary * payDic;
    UIActivityIndicatorView * activityView;
}

@end

@implementation SearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车位详情";
    payDic = [[NSMutableDictionary alloc]init];
    [self creatBaseUI];
    activityView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [activityView setCenter:CGPointMake(WindowWidth / 2 - 15, WindowHeight / 2 - 60)];
    NSArray * array = [_dataDic objectForKey:@"data"];
    if (array.count > 0) {
        NSDictionary * dicOld = array[0];
        imgArray = [dicOld objectForKey:@"spaceImg"];
    }
}
#pragma mark -- tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 11;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (imgArray.count > 0) {
        return WindowHeight / 8;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor clearColor];
    if (imgArray.count > 0) {
        for (int i = 0; i < imgArray.count; i ++) {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WindowWidth / 64, WindowHeight / 35, WindowWidth / 5, WindowHeight / 12)];
            imageView.backgroundColor = [UIColor clearColor];
            [footView addSubview:imageView];
        }
    }
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return WindowHeight / 17;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"系统为你查找到以下车位";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[SearchResultCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray * array = [_dataDic objectForKey:@"data"];
    if (array.count > 0) {
        NSDictionary * dicData = array[0];
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"地址：";
            cell.conLabel.text = [NSString stringWithFormat:@"%@",[dicData objectForKey:@"parkingAddr"]];
        }
        if (indexPath.row == 1) {
            cell.nameLabel.text = @"位置：";
            cell.conLabel.text = [NSString stringWithFormat:@"%@",[dicData objectForKey:@"specificLoc"]];
        }
        if (indexPath.row == 2) {
            cell.nameLabel.text = @"类型及价位：";
            NSString * spaceType;
            if ([[dicData objectForKey:@"spaceType"] integerValue] == 1) {
                spaceType = [NSString stringWithFormat:@"临时卡"];
            }else{
                spaceType = [NSString stringWithFormat:@"月卡"];
            }
            NSString * priceStr;
            if ([[dicData objectForKey:@"priceType"]integerValue] == 1) {
                priceStr = [NSString stringWithFormat:@"每小时%.2f元",[[dicData objectForKey:@"price"] floatValue]];
            }else{
                priceStr = [NSString stringWithFormat:@"每次%.2f元",[[dicData objectForKey:@"price"] floatValue]];
            }
            cell.conLabel.text = [NSString stringWithFormat:@"%@ -- %@",spaceType,priceStr];
        }
        if (indexPath.row == 3) {
            cell.nameLabel.text = @"联系人：";
            cell.conLabel.text = [NSString stringWithFormat:@"%@",[dicData objectForKey:@"contactName"]];
        }
        if (indexPath.row == 4) {
            cell.nameLabel.text = @"电话：";
            cell.conLabel.text = [NSString stringWithFormat:@"%@",[dicData objectForKey:@"contactPhone"]];
        }
        if (indexPath.row == 5) {
            cell.nameLabel.text = @"时间：";
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
            NSDate * startTime = [NSDate dateWithTimeIntervalSince1970:[[dicData objectForKey:@"parkStart"] doubleValue] / 1000];
            NSDate * endTime = [NSDate dateWithTimeIntervalSince1970:[[dicData objectForKey:@"parkEnd"] doubleValue] / 1000];
            cell.conLabel.text = [NSString stringWithFormat:@"%@~%@",[formatter stringFromDate:startTime],[formatter stringFromDate:endTime]];
        }
    }
    return cell;
}
#pragma mark -- 查看地图
-(void)inspectMap{
    MapAddressController * map = [[MapAddressController alloc]init];
    map.mapDaic = _dataDic;
    [self.navigationController pushViewController:map animated:YES];
}
#pragma mark -- 确认租赁
-(void)resultButtonThePark{
    if (backViewButton) {
        [backViewButton removeFromSuperview];
    }
    backViewButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
    backViewButton.backgroundColor = [UIColor grayColor];
    backViewButton.alpha = 0.7;
    backViewButton.userInteractionEnabled = YES;
    [self.view addSubview:backViewButton];
    [self.view addSubview:activityView];
    [activityView startAnimating];
    [self creatParkTrade];
}
//创建交易
-(void)creatParkTrade{
    
    NSArray * array = [_dataDic objectForKey:@"data"];
    NSDictionary * dicOld = array[0];
    NSDictionary * urlDic = @{@"uid":self.baseInfo.myUid,@"orderId":[dicOld objectForKey:@"orderId"],@"parkStart":[dicOld objectForKey:@"parkStart"],@"parkEnd":[dicOld objectForKey:@"parkEnd"]};
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:self.baseInfo.myToken];
    [manager POST:[NSString creatParkingTradeHttpsUrl:self.baseInfo.myURL] parameters:urlDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [activityView stopAnimating];
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary * dataDic = [dic objectForKey:@"data"];
            payDic = [[NSMutableDictionary alloc]initWithDictionary:dataDic];
            [self resultWindow:dataDic];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
#pragma mark -- 下一个
-(void)nextButtonParkMessage{
    NSArray * array = [_dataDic objectForKey:@"data"];
    NSDictionary * dicOld = array[0];
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:self.baseInfo.myToken];
    [manager GET:[NSString nextParkingReqId:[dicOld objectForKey:@"reqId"] httpsUrl:self.baseInfo.myURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        NSLog(@"dic == %@  %@",dic,[dic objectForKey:@"message"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -- 选择支付方式
-(void)moneyButtonForPay{
    [backViewButton removeFromSuperview];
    [self.windowView removeFromSuperview];
    ConfirmRentController * con = [[ConfirmRentController alloc]init];
    con.payDic = payDic;
    [self.navigationController pushViewController:con animated:YES];
}
#pragma mark -- 取消支付
-(void)cleanButtonTheView{
    [self.windowView removeFromSuperview];
    [backViewButton removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
