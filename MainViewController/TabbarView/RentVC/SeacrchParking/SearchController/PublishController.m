//
//  PublishController.m
//  CheWei
//
//  Created by shenyang on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PublishController.h"
#import "PublishController+creatUI.h"
#import "PublishCell.h"
#import "testMapViewController.h"

@interface PublishController ()<testMapViewControllerDeleagte,ZHPickViewDelegate>{
    ZHPickView * _pickView;
    NSMutableDictionary * parkingMapDic;
    NSMutableDictionary * parkingWriteDic;
    NSString * mapOrWrite;/**<0从地图中查找位置，1自己写入*/
}

@end

@implementation PublishController

- (void)viewDidLoad {
     [super viewDidLoad];
     self.title = @"发布找车位需求";
    [self creatBaseUI:self.publishStr];
}
#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_publishStr integerValue]== 0) {
        return 4;
    }else if ([_publishStr integerValue] == 1){
        return 1;
    }else{
        return 4;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return WindowHeight / 9;
    }else if (indexPath.row == 3){
        return WindowHeight / 4;
    }else{
        return WindowHeight / 9;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublishCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[PublishCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"车位地址";
        cell.textField.frame = CGRectMake(0, 0, 0, 0);
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchParkFromMap)];
        _parkTextLabel = [[UILabel alloc]init];
        _parkTextLabel.frame = CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth - CGRectGetWidth(cell.nameLabel.frame), WindowHeight / 9);
        _parkTextLabel.userInteractionEnabled = YES;
        _parkTextLabel.numberOfLines = 0;
        [_parkTextLabel addGestureRecognizer:tap];
        [cell.contentView addSubview:_parkTextLabel];
        if ([_publishStr integerValue] == 0) {
            _parkTextLabel.text = [_publishDic objectForKey:@"parkingAddr"];
        }
    }
    if (indexPath.row == 1) {
        cell.nameLabel.text = @"开始时间";
        _startTimeTextField = cell.textField;
        _startTimeTextField.delegate = self;
    }
    if (indexPath.row == 2) {
        cell.nameLabel.text = @"结束时间";
        _endTimeTextField = cell.textField;
        _endTimeTextField.delegate = self;
    }
    if (indexPath.row == 3) {
        cell.nameLabel.text = @"有效期";
        cell.textField.frame = CGRectMake(0, 0, 0, 0);
        CGRect rect1 = CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth - CGRectGetMaxX(cell.nameLabel.frame), WindowHeight / 4);
        UIView * view = [self creatViewForLastCell:rect1];
        [cell.contentView addSubview:view];
    }

    return cell;
}
#pragma mark -- 从地图中查找车场的位置，并返回
//从地图中查找位置
-(void)searchParkFromMap{
    mapOrWrite = @"0";
    testMapViewController * tex = [[testMapViewController alloc]init];
    tex.delegate = self;
    [self.navigationController pushViewController:tex animated:YES];
}
-(void)publish_mapAddress:(NSDictionary *)addressDic{
    _parkTextLabel.text = [addressDic objectForKey:@"parkingAddr"];
    parkingMapDic = [[NSMutableDictionary alloc]initWithDictionary:addressDic];
}
#pragma mark -- textField delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _cutomsTetxField) {
        if ([self.cutomStr integerValue] == 0) {
            [_cutomsTetxField resignFirstResponder];
        }else{
            NSMutableArray * array1 = [[NSMutableArray alloc]init];
            NSMutableArray * array2 = [[NSMutableArray alloc]init];
            for (int i = 0; i < 24; i ++) {
                NSString * str = [NSString stringWithFormat:@"%d 小时",i];
                [array1 addObject:str];
            }
            for (int i = 0; i < 60; i ++) {
                NSString * str = [NSString stringWithFormat:@"%d 分钟",i];
                [array2 addObject:str];
            }
            NSArray * arr = @[array1,array2];
            _pickView = [[ZHPickView alloc]initPickviewWithArray:arr isHaveNavControler:NO];
            _pickView.delegate = self;
            _pickView.tag = 1000001;
            [_pickView show];
            [_cutomsTetxField resignFirstResponder];
        }
    }
    if (textField == _endTimeTextField) {
        NSDate * date = [NSDate date];
        _pickView = [[ZHPickView alloc]initDatePickWithDate:date datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:NO];
        _pickView.delegate = self;
        _pickView.tag = 1000002;
        [_pickView show];
        [_endTimeTextField resignFirstResponder];
    }
    if (textField == _startTimeTextField) {
        NSDate * date = [NSDate date];
        _pickView = [[ZHPickView alloc]initDatePickWithDate:date datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:NO];
        _pickView.delegate = self;
        _pickView.tag = 1000003;
        [_pickView show];
        [_startTimeTextField resignFirstResponder];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_cutomsTetxField resignFirstResponder];
    [_endTimeTextField resignFirstResponder];
    [_startTimeTextField resignFirstResponder];
    return YES;
}
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if (pickView.tag == 1000001) {
        _cutomsTetxField.text = resultString;
    }
    if (pickView.tag == 1000002) {
        _endTimeTextField.text = resultString;
    }
    if (pickView.tag == 1000003) {
        _startTimeTextField.text = resultString;
    }
}
#pragma mark -- HTTPS
//发布要找的车位
-(void)publishSrarchPark{
    NSMutableDictionary * dicD = [[NSMutableDictionary alloc]init];
    [dicD setValue:self.baseInfo.myUid forKey:@"uid"];
    [dicD setValue:_parkTextLabel.text forKey:@"parkingAddr"];
    if ([mapOrWrite integerValue] == 0) {
        if ([parkingMapDic objectForKey:@"latitude"]) {
            NSNumber * la = [NSNumber numberWithDouble:[[parkingMapDic objectForKey:@"latitude"] doubleValue]];
            [dicD setValue:la forKey:@"lat"];
        }
        if ([parkingMapDic objectForKey:@"longitude"]) {
            NSNumber * ln = [NSNumber numberWithDouble:[[parkingMapDic objectForKey:@"longitude"] doubleValue]];
            [dicD setValue:ln forKey:@"lng"];
        }
    }else{
        if ([parkingWriteDic objectForKey:@"lat"]) {
            NSNumber * la = [NSNumber numberWithDouble:[[parkingWriteDic objectForKey:@"lat"] doubleValue]];
            [dicD setValue:la forKey:@"lat"];
        }
        if ([parkingWriteDic objectForKey:@"lng"]) {
            NSNumber * ln = [NSNumber numberWithDouble:[[parkingWriteDic objectForKey:@"lng"] doubleValue]];
            [dicD setValue:ln forKey:@"lng"];
        }
        if ([parkingWriteDic objectForKey:@"parkingAddr"]) {
            NSNumber * ln = [NSNumber numberWithDouble:[[parkingWriteDic objectForKey:@"parkingAddr"] doubleValue]];
            [dicD setValue:ln forKey:@"parkingAddr"];
        }
        if ([parkingWriteDic objectForKey:@"parkingID"]) {
            NSNumber * ln = [NSNumber numberWithDouble:[[parkingWriteDic objectForKey:@"parkingID"] doubleValue]];
            [dicD setValue:ln forKey:@"parkingId"];
        }
    }
    [dicD setValue:_startTimeTextField.text forKey:@"parkStart"];
    [dicD setValue:_endTimeTextField.text forKey:@"parkEnd"];
    if ([_cutomStr integerValue] == 0) {
        NSNumber * willExpire = [NSNumber numberWithInt:0];
        [dicD setValue:willExpire forKey:@"willExpire"];
    }else{
        NSArray * timeA = [_cutomsTetxField.text componentsSeparatedByString:@"小时"];
        NSArray * Stime = [timeA[1] componentsSeparatedByString:@"分钟"];
        int allTime = [timeA[0] intValue] * 60 + [Stime[0] intValue];
        NSNumber * willExpire = [NSNumber numberWithInt:allTime];
        [dicD setValue:willExpire forKey:@"willExpire"];
    }
    if ([self.setOftenParking intValue] == 1) {
        NSNumber * set = [NSNumber numberWithBool:YES];
        [dicD setValue:set forKey:@"isFrequent"];
    }else{
        NSNumber * set = [NSNumber numberWithBool:NO];
        [dicD setValue:set forKey:@"isFrequent"];
    }
    NSDictionary * dicOld = [[NSDictionary alloc]initWithDictionary:dicD];
    [self HTTPSpublishSrarchPark:dicOld];
}
//发布找车位
-(void)HTTPSpublishSrarchPark:(NSDictionary *)dicOld{
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager POST:[NSString searchParkBasisNeed:self.baseInfo.myURL] parameters:dicOld progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic0 = [SB_DayI analysisMessage:responseObject];
        if ([[dic0 objectForKey:@"code"] integerValue] == 0) {
            [self showHint:@"发布成功"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"searchParkBasisNeedSuccessd" object:self userInfo:dic0];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([[dic0 objectForKey:@"code"] integerValue] == 12){
            TTAlert1(@"请完善信息", self);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        L1(error);
    }];
    
}
//添加常找的车位
-(void)addOftenSearchPark{
    NSDictionary * dic = @{@"uid":self.baseInfo.myUid,@"parkingAddr":_parkTextLabel.text};
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager POST:[NSString addSearchParkAddress:self.baseInfo.myURL] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic0 = [SB_DayI analysisMessage:responseObject];
        if ([[dic0 objectForKey:@"code"] integerValue] == 0) {
            [self showHint:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
//删除某一常找车位
-(void)deleteOftenSearchPark:(UIButton *)sender{
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    NSString * urlD = [NSString stringWithFormat:@"%ld",sender.tag - 17000];
    [manager DELETE:[NSString deleteOneOftenPark:urlD  httpsUrl:self.baseInfo.myURL] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            [self showHint:@"删除成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)setOftenParkingForButton{
    if (self.setOftenParking == nil) {
        self.setOftenParking = @"1";
        [self.commonlyButton setTitle:@"取消设置" forState:UIControlStateNormal];
    }else{
        if ([self.setOftenParking integerValue] == 1) {
            self.setOftenParking = @"0";
            [self.commonlyButton setTitle:@"设为常用车位" forState:UIControlStateNormal];
        }else{
            self.setOftenParking = @"1";
            [self.commonlyButton setTitle:@"取消设置" forState:UIControlStateNormal];
        }
    }
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
