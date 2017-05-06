//
//  Rent_ParkViewController.m
//  CheWei
//
//  Created by shenyang on 16/4/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Rent_ParkViewController.h"
#import "Rent_ParkViewController+createUI.h"
#import "Rent_parkCell.h"
#import "Rent_parkID.h"
#import "Rent_parkIDController.h"
@interface Rent_ParkViewController ()<Rent_prakIDControllerDelegate>{
    
    UILabel * _Packlabel;
    UILabel * startTimeLabel;
    UILabel * endTimeLabel;
    NSMutableDictionary * postDic;/**<传递的参数*/
    NSString * parkIDStr;/**<车场的ID*/
    NSString * isFrequent;/**<是否是常用车位，0不是，1是*/
}

@end

@implementation Rent_ParkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑放租车位信息";
    postDic = [[NSMutableDictionary alloc]init];
    if ([_actionStr integerValue] == 0) {
        [self creatBaseUI:WindowHeight * 3 / 10 Str:@"3"];
    }else if ([_actionStr integerValue] == 1){
        [self creatBaseUI:WindowHeight * 7 / 10 Str:@"7"];
    }else{
        [self creatBaseUI:WindowHeight * 7 / 10 Str:@"9"];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_actionStr integerValue] == 0) {
        return 3;
    }else if ([_actionStr integerValue] == 1){
        return 7;
    }else{
        return 9;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Rent_parkCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if (cell == nil) {
        cell = [[Rent_parkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGRect rect1 = CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth * 5 / 6 - 5, WindowHeight / 10);
    if ([_actionStr integerValue] == 0) {
        //放租
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"车位信息：";
            _parkInformation = [self writeInformation_park:rect1];
            _parkInformation.delegate = self;
            _parkInformation.text = [_spaceDic objectForKey:@"specificLoc"];
            [cell addSubview:_parkInformation];
        }
        if (indexPath.row == 1){
            _Packlabel = [self prace_park:CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth * 2 / 6, WindowHeight / 10)];
            _Packlabel.textAlignment = NSTextAlignmentCenter;
            _Packlabel.font = [UIFont systemFontOfSize:[[NSString fontForDifferentTextSize:@"15"] floatValue]];
            [cell addSubview:_Packlabel];
            if ([[_spaceDic objectForKey:@"priceType"] intValue] == 1) {
                _Packlabel.text = @"每小时";
            }else{
                _Packlabel.text = @"每次";
            }
            _rentPrice = [self writeInformation_park:CGRectMake(CGRectGetMaxX(_Packlabel.frame), 0, WindowWidth * 2 / 6 , WindowHeight / 10)];
            _rentPrice.delegate = self;
            [cell addSubview:_rentPrice];
            UILabel * Jlabel = [CreatUI creatLabelWithFrame:CGRectMake(CGRectGetMaxX(_rentPrice.frame), 0, WindowWidth / 12, WindowHeight / 10) Text:@"元" TextFont:[[NSString fontForDifferentTextSize:@"15"] floatValue] BackgroudColor:nil TextColor:BLACK_color];
            Jlabel.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:Jlabel];
            _rentPrice.placeholder = @"点击输入价格";
            _rentPrice.text = [NSString stringWithFormat:@"%.2f", [[_spaceDic objectForKey:@"price"] doubleValue]];
            cell.nameLabel.text = @"出租价格：";
        }
        if (indexPath.row == 2) {
            startTimeLabel = [[UILabel alloc]init];
            endTimeLabel = [[UILabel alloc]init];
            UIView * vi =[self time_park:CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth * 3 / 4 - 5, WindowHeight / 10) StartTime:startTimeLabel EndTime:endTimeLabel];
            [cell addSubview:vi];
            cell.nameLabel.text = @"出租时间：";
        }
    }else if ([_actionStr integerValue] == 1){
        //添加常用车位
        if (indexPath.row == 0) {
            UIView * view = [self creatIndexOne:CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth * 3 / 4 - 5, WindowHeight / 10)];
            [cell addSubview:view];
            cell.nameLabel.text = @"车位类型：";
        }
        if (indexPath.row == 1){
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressLabelTap)];
            _parkAdress = [CreatUI creatLabelWithFrame:rect1 Text:nil TextFont:[[NSString fontForDifferentTextSize:@"15"] floatValue] BackgroudColor:[UIColor clearColor] TextColor:[UIColor blueColor]];
            _parkAdress.userInteractionEnabled = YES;
            [_parkAdress addGestureRecognizer:tap];
            if ([_spaceDic objectForKey:@"specificLoc"]) {
                _parkAdress.text = [_spaceDic objectForKey:@"specificLoc"];
            }
            [cell addSubview:_parkAdress];
           cell.nameLabel.text = @"车位地址：";
        }
        if (indexPath.row == 2){
            _contactName = [self writeInformation_park:rect1];
            _contactName.delegate = self;
            if ([_spaceDic objectForKey:@"contactName"]) {
                _contactName.text = [_spaceDic objectForKey:@"contactName"];
            }
            [cell addSubview:_contactName];
            cell.nameLabel.text = @"联系人：";
        }
        if (indexPath.row == 3){
            _contactPhone = [self writeInformation_park:rect1];
            _contactPhone.delegate = self;
            if ([_spaceDic objectForKey:@"contactPhone"]) {
                _contactPhone.text = [_spaceDic objectForKey:@"contactPhone"];
            }
            [cell addSubview:_contactPhone];
            cell.nameLabel.text = @"手机：";
        }
        if (indexPath.row == 4){
            UIView * imageView = [self photos_park:CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth * 3 / 4, WindowHeight / 10)];
            [cell addSubview:imageView];
            cell.nameLabel.text = @"添加照片：";
        }
        if (indexPath.row == 5){
            _parkInformation = [self writeInformation_park:rect1];
            _parkInformation.delegate = self;
            [cell addSubview:_parkInformation];
           cell.nameLabel.text = @"车位信息：";
        }
        if (indexPath.row == 6){
            _Packlabel = [self prace_park:CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth * 2 / 6, WindowHeight / 10)];
            if ([_spaceDic objectForKey:@"priceType"]) {
                if ([[_spaceDic objectForKey:@"priceType"]intValue] == 0) {
                    _Packlabel.text = @"按次：";
                }else{
                    _Packlabel.text = @"按小时：";
                }
            }
            [cell addSubview:_Packlabel];
            _rentPrice = [self writeInformation_park:CGRectMake(CGRectGetMaxX(_Packlabel.frame), 0, WindowWidth * 2 / 6 - 5, WindowHeight / 10)];
            _rentPrice.delegate = self;
            _rentPrice.placeholder = @"点击输入价格";
            if ([_spaceDic objectForKey:@"price"]) {
                _rentPrice.text = [NSString stringWithFormat:@"%d",[[_spaceDic objectForKey:@"price"] intValue]];
            }
            [cell addSubview:_rentPrice];
            UILabel * Jlabel = [CreatUI creatLabelWithFrame:CGRectMake(CGRectGetMaxX(_rentPrice.frame), 0, WindowWidth / 12, WindowHeight / 10) Text:@"元" TextFont:[[NSString fontForDifferentTextSize:@"15"] floatValue] BackgroudColor:nil TextColor:BLACK_color];
            Jlabel.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:Jlabel];
            cell.nameLabel.text = @"出租价位：";
        }
    }else{
        //添加其他车位
        if (indexPath.row == 0) {
            UIView * view = [self creatIndexOne:CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth * 3 / 4 - 5, WindowHeight / 10)];
            [cell addSubview:view];
            cell.nameLabel.text = @"车位类型：";
        }
        if (indexPath.row == 1){
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressLabelTap)];
            _parkAdress = [CreatUI creatLabelWithFrame:rect1 Text:nil TextFont:[[NSString fontForDifferentTextSize:@"15"] floatValue] BackgroudColor:[UIColor clearColor] TextColor:[UIColor blueColor]];
            [_parkAdress addGestureRecognizer:tap];
            _parkAdress.userInteractionEnabled = YES;
            [cell addSubview:_parkAdress];
            cell.nameLabel.text = @"车库地址：";
        }
        if (indexPath.row == 2){
            _contactName = [self writeInformation_park:rect1];
            _contactName.delegate = self;
            [cell addSubview:_contactName];
            cell.nameLabel.text = @"联系人：";
        }
        if (indexPath.row == 3){
            _contactPhone = [self writeInformation_park:rect1];
            _contactPhone.delegate = self;
            [cell addSubview:_contactPhone];
            cell.nameLabel.text = @"手机：";
        }
        if (indexPath.row == 4){
            UIView * imageView = [self photos_park:CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth * 3 / 4, WindowHeight / 10)];
            [cell addSubview:imageView];
            cell.nameLabel.text = @"车位照片：";
        }
        if (indexPath.row == 5){
            _parkInformation = [self writeInformation_park:rect1];
            _parkInformation.delegate = self;
            [cell addSubview:_parkInformation];
            cell.nameLabel.text = @"车位信息：";
        }
        if (indexPath.row == 6){
            _Packlabel = [self prace_park:CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth * 2 / 6, WindowHeight / 10)];
            [cell addSubview:_Packlabel];
            _rentPrice = [self writeInformation_park:CGRectMake(CGRectGetMaxX(_Packlabel.frame), 0, WindowWidth * 2 / 6 - 5, WindowHeight / 10)];
            _rentPrice.delegate = self;
            _rentPrice.placeholder = @"点击输入价格";
            [cell addSubview:_rentPrice];
            UILabel * Jlabel = [CreatUI creatLabelWithFrame:CGRectMake(CGRectGetMaxX(_rentPrice.frame), 0, WindowWidth / 12, WindowHeight / 10) Text:@"元" TextFont:[[NSString fontForDifferentTextSize:@"15"] floatValue] BackgroudColor:nil TextColor:BLACK_color];
            Jlabel.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:Jlabel];
            cell.nameLabel.text = @"出租价格：";
        }
        if (indexPath.row == 7){
            startTimeLabel = [[UILabel alloc]init];
            endTimeLabel = [[UILabel alloc]init];
            UIView * vi =[self time_park:CGRectMake(CGRectGetMaxX(cell.nameLabel.frame), 0, WindowWidth * 3 / 4 - 5, WindowHeight / 10) StartTime:startTimeLabel EndTime:endTimeLabel];
            [cell addSubview:vi];
            cell.nameLabel.text = @"出租时间：";
        }
        if (indexPath.row == 8){
            cell.nameLabel.text = @"管理员：";
        }

    }
    return cell;
}
#pragma mark -- 发布车位
-(void)publishPark{
    if ([_actionStr integerValue] == 0) {
//        NSLog(@"发布车位");
        NSMutableDictionary * rentDic = [[NSMutableDictionary alloc]init];
        [rentDic setValue:self.baseInfo.myUid forKey:@"uid"];
        [rentDic setValue:[_spaceDic objectForKey:@"spaceId"] forKey:@"spaceId"];
        [rentDic setValue:startTimeLabel.text forKey:@"parkStart"];
        [rentDic setValue:endTimeLabel.text forKey:@"parkEnd"];
        [rentDic setValue:[NSNumber numberWithDouble:[_rentPrice.text doubleValue]] forKey:@"price"];
        NSNumber * pric;
        if ([_Packlabel.text isEqualToString:@"每小时："]) {
            pric = [NSNumber numberWithInt:1];
        }else{
            pric = [NSNumber numberWithInt:0];
        }
        NSInteger count = 0;
        [rentDic setValue:pric forKey:@"priceType"];
        for (NSString * dicRent in [rentDic allValues]) {
            if (dicRent == nil) {

            }else{
                count ++;
            }
        }
        if (count == 6) {
            [self HTTPSPublishRent:rentDic];
        }else{
            TTAlert1(@"信息输入不完整", self);
        }
    }else if ([_actionStr integerValue] == 1){
//保存车位为常放租车位
        if (isFrequent) {
            if ([isFrequent integerValue] == 0) {
                isFrequent = @"1";
                [self.publishBu setTitle:@"取消设置" forState:UIControlStateNormal];
                [self.publishBu setBackgroundColor:[UIColor redColor]];
            }else{
                isFrequent = @"0";
                [self.publishBu setTitle:@"设为常租放车位" forState:UIControlStateNormal];
                [self.publishBu setBackgroundColor:RGBcolor(230, 230, 230, 1)];
            }
        }else{
            isFrequent = @"1";
            [self.publishBu setTitle:@"取消设置" forState:UIControlStateNormal];
            [self.publishBu setBackgroundColor:[UIColor redColor]];
        }
        NSMutableDictionary * newDic = [[NSMutableDictionary alloc]init];
        NSNumber * spaceType = [NSNumber numberWithInteger:[self.packType integerValue]];
        NSNumber * isFre = [NSNumber numberWithInt:[isFrequent intValue]];
        [newDic setValue:spaceType forKey:@"spaceType"];
        [newDic setValue:isFre forKey:@"isFrequent"];
        [newDic setValue:parkIDStr forKey:@"parkingId"];
        [newDic setValue:self.baseInfo.myUid forKey:@"uid"];
        [newDic setValue:_parkInformation.text forKey:@"specificLoc"];
        [newDic setValue:_contactName.text forKey:@"contactName"];
        [newDic setValue:_contactPhone.text forKey:@"contactPhone"];
        [newDic setValue:_rentPrice.text forKey:@"price"];
        NSNumber * pric;
        if ([_Packlabel.text isEqualToString:@"每小时："]) {
            pric = [NSNumber numberWithInt:1];
        }else{
            pric = [NSNumber numberWithInt:0];
        }
        [newDic setValue:pric forKey:@"priceType"];
        [self HTTPSOftenRent:newDic];
    }else{
        if (isFrequent) {
            if ([isFrequent integerValue] == 0) {
                isFrequent = @"1";
                [self.publishBu setTitle:@"取消设置" forState:UIControlStateNormal];
                [self.publishBu setBackgroundColor:[UIColor redColor]];
            }else{
                isFrequent = @"0";
                [self.publishBu setTitle:@"设为常租放车位" forState:UIControlStateNormal];
                [self.publishBu setBackgroundColor:RGBcolor(230, 230, 230, 1)];
            }
        }else{
            isFrequent = @"1";
            [self.publishBu setTitle:@"取消设置" forState:UIControlStateNormal];
            [self.publishBu setBackgroundColor:[UIColor redColor]];
        }
        NSMutableDictionary * newDic = [[NSMutableDictionary alloc]init];
        NSNumber * spaceType = [NSNumber numberWithInteger:[self.packType integerValue]];
        NSNumber * isFre = [NSNumber numberWithInt:[isFrequent intValue]];
        [newDic setValue:spaceType forKey:@"spaceType"];
        [newDic setValue:isFre forKey:@"isFrequent"];
        [newDic setValue:parkIDStr forKey:@"parkingId"];
        [newDic setValue:self.baseInfo.myUid forKey:@"uid"];
        [newDic setValue:_parkInformation.text forKey:@"specificLoc"];
        [newDic setValue:_contactName.text forKey:@"contactName"];
        [newDic setValue:_contactPhone.text forKey:@"contactPhone"];
        [newDic setValue:_rentPrice.text forKey:@"price"];
        NSNumber * pric;
        if ([_Packlabel.text isEqualToString:@"每小时："]) {
            pric = [NSNumber numberWithInt:1];
        }else{
            pric = [NSNumber numberWithInt:0];
        }
        [newDic setValue:pric forKey:@"priceType"];
        [self HTTPSOftenRent:newDic];
    }
}
#pragma mark -- 保存车位
-(void)savePark{
    if ([_actionStr integerValue] == 0) {
//        NSLog(@"该按钮无此选项");
    }else if ([_actionStr integerValue] == 1){
        NSNumber * spaceType = [NSNumber numberWithInteger:[self.packType integerValue]];
        NSNumber * isFre = [NSNumber numberWithInt:[isFrequent intValue]];
        [postDic setValue:spaceType forKey:@"spaceType"];
        [postDic setValue:isFre forKey:@"isFrequent"];
        [postDic setValue:startTimeLabel.text forKey:@"parkStart"];
        [postDic setValue:endTimeLabel.text forKey:@"parkEnd"];
        [postDic setValue:parkIDStr forKey:@"parkingId"];
        [postDic setValue:self.baseInfo.myUid forKey:@"uid"];
        NSNumber * pric;
        if ([_Packlabel.text isEqualToString:@"每小时："]) {
            pric = [NSNumber numberWithInt:1];
        }else{
            pric = [NSNumber numberWithInt:0];
        }
        [postDic setValue:pric forKey:@"priceType"];
        [self HTTPSOftenRent:postDic];
    }else{
        NSNumber * spaceType = [NSNumber numberWithInt:[self.packType intValue]];
        NSNumber * intNub = [NSNumber numberWithInt:[isFrequent intValue]];
        [postDic setValue:spaceType forKey:@"spaceType"];
        [postDic setValue:intNub forKey:@"isFrequent"];
        [postDic setValue:startTimeLabel.text forKey:@"parkStart"];
        [postDic setValue:endTimeLabel.text forKey:@"parkEnd"];
        [postDic setValue:parkIDStr forKey:@"parkingId"];
        [postDic setValue:self.baseInfo.myUid forKey:@"uid"];
        NSNumber * pric;
        if ([_Packlabel.text isEqualToString:@"每小时："]) {
            pric = [NSNumber numberWithInt:1];
        }else{
            pric = [NSNumber numberWithInt:0];
        }
        [postDic setValue:pric forKey:@"priceType"];
        [self HTTPSSaveParkAndPublish:postDic];
    }
}
#pragma mark -- ZHPickView delegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if (pickView.tag == 1100000) {
        _Packlabel.text = resultString;
    }
    if (pickView.tag == 1100001) {
        NSArray * array = [resultString componentsSeparatedByString:@":"];
        NSString * result = [NSString stringWithFormat:@"%@:%@",array[0],array[1]];
        startTimeLabel.text = result;
    }
    if (pickView.tag == 1100002) {
        NSArray * array = [resultString componentsSeparatedByString:@":"];
        NSString * result = [NSString stringWithFormat:@"%@:%@",array[0],array[1]];
        endTimeLabel.text = result;
    }
}
#pragma mark -- Rent_parkIDController delegate
-(void)addressLabelTap{
    Rent_parkIDController * ren = [[Rent_parkIDController alloc]init];
    ren.delegate = self;
    [self.navigationController pushViewController:ren animated:YES];
}
-(void)writeAddressParkID:(NSDictionary *)parkDic{
    _parkAdress.text = [parkDic objectForKey:@"parkingAddr"];
    parkIDStr = [parkDic objectForKey:@"parkingID"];
}
#pragma mark -- TextField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _parkInformation) {
        [postDic setValue:textField.text forKey:@"specificLoc"];
    }
    if (textField == _contactName) {
        [postDic setValue:textField.text forKey:@"contactName"];
    }
    if (textField == _contactPhone) {
        [postDic setValue:textField.text forKey:@"contactPhone"];
    }
    if (textField == _rentPrice) {
        NSNumber * prace = [NSNumber numberWithDouble:[textField.text doubleValue]];
        [postDic setValue:prace forKey:@"price"];
    }
}
#pragma mark -- HTTPS
//保存并发布车位
-(void)HTTPSSaveParkAndPublish:(NSDictionary *)rentDic{
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager POST:[NSString setUpAndPublishPark:self.baseInfo.myURL] parameters:postDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"]integerValue] == 0) {
            [self showHint:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([[dic objectForKey:@"code"] integerValue] == 12){
            TTAlert1([dic objectForKey:@"message"], self);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        L1(error);
    }];
}
//保存车位
-(void)HTTPSOftenRent:(NSDictionary *)rentDic{
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager POST:[NSString setUpNewParkInformation:self.baseInfo.myURL] parameters:rentDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
//        NSLog(@"保存车位的数据  %@",dic);
        if ([[dic objectForKey:@"code"]integerValue] == 0) {
            [self showHint:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([[dic objectForKey:@"code"] integerValue] == 12){
            TTAlert1([dic objectForKey:@"message"], self);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
    }];
}
//发布租放车位
-(void)HTTPSPublishRent:(NSDictionary *)rentDic{
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager POST:[NSString publishPark:[_spaceDic objectForKey:@"spaceId"] httpsUrl:self.baseInfo.myURL] parameters:rentDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"]integerValue] == 0) {
            [self showHint:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([[dic objectForKey:@"code"] integerValue] == 12){
            TTAlert1([dic objectForKey:@"message"], self);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
