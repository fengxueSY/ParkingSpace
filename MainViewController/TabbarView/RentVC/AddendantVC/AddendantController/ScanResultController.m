//
//  ScanResultController.m
//  CheWei
//
//  Created by shenyang on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ScanResultController.h"
#import "ScanResultController+creatUI.h"
#import "ScanResultCell.h"

@interface ScanResultController ()

@end

@implementation ScanResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫码结果";
    int a = arc4random()%2;
    [self creatBaseUI:[NSString stringWithFormat:@"%d",a]];
}
#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return WindowHeight / 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]init];
    headView.backgroundColor = RGBcolor(250, 250, 250, 1);
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight / 10)];
    label.textColor = BLACK_color;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"扫码结果";
    [headView addSubview:label];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return WindowHeight / 13;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView = [[UIView alloc]init];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight / 13)];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"已离场(2016-05-19 10:29)";
    [footView addSubview:label];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 9;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScanResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[ScanResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"订单号";
        cell.contentLabel.text = @"42983740238746";
    }
    if (indexPath.row == 1) {
        cell.nameLabel.text = @"车位";
        cell.contentLabel.text = @"负一层B1234";
    }
    if (indexPath.row == 2) {
        cell.nameLabel.text = @"出租时间";
        cell.contentLabel.text = @"2016-05-12 12:56~2016-15-14 09:29";
    }
    if (indexPath.row == 3) {
        cell.nameLabel.text = @"租金";
        cell.contentLabel.text = @"共计300元，单价：30/小时";
    }
    if (indexPath.row == 4) {
        cell.nameLabel.text = @"出租人";
        cell.contentLabel.text = @"王小姐";
    }
    if (indexPath.row == 5) {
        cell.nameLabel.text = @"电话";
        cell.contentLabel.text = @"42983740238746";
    }
    if (indexPath.row == 6) {
        cell.nameLabel.text = @"租客";
        cell.contentLabel.text = @"王先生";
    }
    if (indexPath.row == 7) {
        cell.nameLabel.text = @"电话";
        cell.contentLabel.text = @"42983740238746";
    }
    return cell;
}
#pragma mark -- HTTPS
#pragma mark -- 确认进场操作
-(void)addendantConfirmEntering{
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:self.baseInfo.myToken];
    [manager POST:[NSString scanImageOrder_operationHttpsUrl:self.baseInfo.myURL] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -- 确认出场操作
-(void)addendantConfirmLeaving{
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:self.baseInfo.myToken];
    [manager POST:[NSString scanImageOrder_operationHttpsUrl:self.baseInfo.myURL] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
