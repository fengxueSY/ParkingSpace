//
//  SearchRecordController.m
//  CheWei
//
//  Created by shenyang on 16/4/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchRecordController.h"
#import "SearchRecordController+creatUI.h"
#import "SearchRecordCell.h"
#import "Search_history.h"

@interface SearchRecordController (){
    NSMutableArray * _dataArray;
}

@end

@implementation SearchRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找车记录";
    _dataArray = [[NSMutableArray alloc]init];
    [self HttpsSearchList];
    [self creatBaseUI];
}
#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[SearchRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Search_history * history = _dataArray[indexPath.row];
    cell.addressLabel.text = history.parkingAddr;
    NSString * createdStr = [self stringChangeDate:history.created];
    cell.timeLabel.text = [NSString stringWithFormat:@"创建时间：%@",createdStr];
    if ([history.willExpire integerValue] == 0) {
     cell.offectiveLabel.text = @"发起时有效";
    }else{
        cell.offectiveLabel.text = [NSString stringWithFormat:@"有效时间：%@分钟",history.willExpire];
    }
    NSString * startTime = [self stringChangeDate:history.parkStart];
    NSString * endTime = [self stringChangeDate:history.parkEnd];
    cell.startAndEndLabel.text = [NSString stringWithFormat:@"时间段：%@~%@",startTime,endTime];
    if ([history.isFrequent integerValue] == 0) {
        [cell.oftenButton setTitle:@"非常用车位" forState:UIControlStateNormal];
    }else{
        [cell.oftenButton setTitle:@"常用车位" forState:UIControlStateNormal];
    }
    cell.oftenButton.tag = 20160517 + indexPath.row;
    [cell.oftenButton addTarget:self action:@selector(setOftenSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    if ([history.status integerValue] == 0) {
        [cell.offectiveButton setTitle:@"有效" forState:UIControlStateNormal];
        cell.offectiveButton.tag = 900000 + indexPath.row;
        [cell.offectiveButton addTarget:self action:@selector(offectiveButtonChange:) forControlEvents:UIControlEventTouchUpInside];
    }else if ([history.status integerValue] == 1){
        [cell.offectiveButton setTitle:@"已取消" forState:UIControlStateNormal];
    }else{
        [cell.offectiveButton setTitle:@"已过期" forState:UIControlStateNormal];
    }
    cell.cleacButton.tag = 900001 + indexPath.row;
    [cell.cleacButton addTarget:self action:@selector(cleanTheSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark -- https
-(void)HttpsSearchList{
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager GET:[NSString searchParkInHistory:self.baseInfo.myUid httpsUrl:self.baseInfo.myURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            NSArray * dataArray = [dic objectForKey:@"data"];
            for (NSDictionary * dicOld in dataArray) {
                Search_history * history = [[Search_history alloc]init];
                [history setValuesForKeysWithDictionary:dicOld];
                [_dataArray addObject:history];
            }
          [_recordTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}
-(void)setOftenSearchButton:(UIButton *)sender{
    Search_history * history = _dataArray[sender.tag - 20160517];
    if ([history.isFrequent integerValue] == 0) {
        [self setOftenSearchParking:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }else{
        [self deleteSearchParking:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
}
//修改为不常用车位
-(void)deleteSearchParking:(NSString *)sender{
    Search_history * history = _dataArray[[sender integerValue] - 20160517];
    
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager DELETE:[NSString deleteOneOftenPark:history.parkingId httpsUrl:self.baseInfo.myURL] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            history.isFrequent = @"0";
            history.parkingId = nil;
            NSIndexPath * index = [NSIndexPath indexPathForRow:([sender integerValue] - 20160517) inSection:0];
            [_recordTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        L1(error);
    }];
}
//修改为常用找车位
-(void)setOftenSearchParking:(NSString *)sender{
    Search_history * history = _dataArray[[sender integerValue] - 20160517];
    NSDictionary * dicOld = @{@"uid":self.baseInfo.myUid,@"parkingAddr":history.parkingAddr};
    AFHTTPSessionManager * manager = [AFN_DayI requestHeader_JSON:self.baseInfo.myToken];
    [manager POST:[NSString addSearchParkAddress:self.baseInfo.myURL] parameters:dicOld progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            [self showHint:@"添加成功"];
            history.isFrequent = @"1";
            history.parkingId = [[dic objectForKey:@"data"]objectForKey:@"addressId"];
            NSIndexPath * index = [NSIndexPath indexPathForRow:([sender integerValue] - 20160517) inSection:0];
            [_recordTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        L1(error);
    }];
}
//是否取消该车位
-(void)offectiveButtonChange:(UIButton *)sender{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消有效将收不到有关该车位的信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ale = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Search_history * history = _dataArray[sender.tag - 900000];
        AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
        [manager GET:[NSString cleanOffectivePark:history.reqId httpsUrl:self.baseInfo.myURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
            if ([[dic objectForKey:@"code"] integerValue] == 0) {
                history.status = @"2";
                [_recordTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:sender.tag - 900000 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }];
    UIAlertAction * alA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:ale];
    [alert addAction:alA];
    [self presentViewController:alert animated:YES completion:nil];
}
//删除某一条历史记录
-(void)cleanTheSearchButton:(UIButton *)sender{
    Search_history * history = _dataArray[sender.tag - 900001];
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager DELETE:[NSString deleteSearchPark:history.reqId httpsUrl:self.baseInfo.myURL] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            [_dataArray removeObject:_dataArray[sender.tag - 900001]];
            [_recordTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(NSString *)stringChangeDate:(NSString *)timeString{
    NSString * newString;
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[timeString floatValue] / 1000];
    newString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    return newString;
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
