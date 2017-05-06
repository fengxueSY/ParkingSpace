//
//  RentSearchController.m
//  CheWei
//
//  Created by shenyang on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RentSearchController.h"
#import "RentCell.h"
#import "SearchCell.h"
#import "SearchParkModel.h"
#import "RentParkModel.h"
#import "PublishController.h"
#import "Rent_ParkViewController.h"
#import "MyRentParkController.h"
#import "SearchRecordController.h"
#import "RentSearchController+creatUI.h"
#import "ScanResultController.h"
#import "RecordController.h"
@interface RentSearchController (){
    NSMutableArray * _searchDataArray;
    NSMutableArray * _rentDataArray;
    NSUserDefaults * _userDefaults;
}

@end

@implementation RentSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userDefaults = [NSUserDefaults standardUserDefaults];
    _searchDataArray = [[NSMutableArray alloc]init];
    _rentDataArray = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"menuButtonNotificationTitle" object:self userInfo:@{@"title":@"操作记录"}];
    if ([self.baseInfo.myRole integerValue] == 0) {
        //普通用户
        [self creatBaseUI];
    }else{
        // 管理员
    }
}
-(void)viewWillAppear:(BOOL)animated{
//先去本地缓存，改善用户刚进入时会出现空白界面的情况，再使用网络请求，防止在其他界面对常用车位操作，造成界面刷新不及时
    NSData * searchData = [_userDefaults objectForKey:@"searchHttpsData"];
    NSArray * searchArray = [NSKeyedUnarchiver unarchiveObjectWithData:searchData];
    for (NSDictionary * dicNew in searchArray) {
        SearchParkModel * model = [[SearchParkModel alloc]init];
        [model setValuesForKeysWithDictionary:dicNew];
        [_searchDataArray addObject:model];
    }
    [_SearchTabelView reloadData];
    NSData * rentData = [_userDefaults objectForKey:@"rentHttpsData"];
    NSArray * rentArray = [NSKeyedUnarchiver unarchiveObjectWithData:rentData];
    for (NSDictionary * dicNew in rentArray) {
        RentParkModel * model = [[RentParkModel alloc]init];
        [model setValuesForKeysWithDictionary:dicNew];
        [_rentDataArray addObject:model];
    }
    [_RentTabelView reloadData];
    [self httpsDiscoverPark];
    [self httpsLosserPark_space];
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter]removeObserver:@"跳转到记录界面"];
//}
#pragma mark -- tableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _SearchTabelView) {
        SearchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (cell == nil) {
            cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
        }
        CGRect rect = CGRectMake(0, 0, 0, 0);
        float w = WindowWidth;
        float h = (WindowHeight - 64) * 11 / 54;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == _searchDataArray.count) {
            cell.otherButton.tag = 680000;
            [cell.otherButton setTitle:@"添加常找车位" forState:UIControlStateNormal];
            [cell.otherButton addTarget:self action:@selector(cellOtherButttonViewController:) forControlEvents:UIControlEventTouchUpInside];
            cell.otherButton.frame = CGRectMake(w / 4, h / 4, w / 2, h / 2);
            cell.addressLabel.frame = rect;
            cell.timeLabel.frame = rect;
            cell.startButton.frame = rect;
            cell.deleteButton.frame = rect;
        }else if (indexPath.row < _searchDataArray.count){
            cell.otherButton.frame = CGRectMake(0, 0, 0, 0);
            cell.addressLabel.frame = CGRectMake(w / 32, h / 12, w * 23 / 32, h * 3 / 6);
            cell.timeLabel.frame = CGRectMake(w / 32, CGRectGetMaxY(cell.addressLabel.frame), w * 23 / 32, h * 2 / 6);
            cell.startButton.frame = CGRectMake(w * 25 / 32, h / 9, w * 6 / 32, h / 3);
            cell.deleteButton.frame = CGRectMake(w * 25 / 32, h * 5 / 9, w * 6 / 32, h / 3);

            SearchParkModel * model = _searchDataArray[indexPath.row];
            cell.addressLabel.text = model.parkingAddr;
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
            NSDate * date = [NSDate dateWithTimeIntervalSince1970:[model.created floatValue] / 1000];
            NSString * created = [NSString stringWithFormat:@"发布时间：%@",[formatter stringFromDate:date]];
            cell.timeLabel.text = created;
            [cell.startButton setTitle:@"从这里找" forState:UIControlStateNormal];
            cell.startButton.tag = 1800 + indexPath.row;
            [cell.startButton addTarget:self action:@selector(searchCellButton:) forControlEvents:UIControlEventTouchUpInside];
            cell.deleteButton.tag = 1900 + indexPath.row;
            [cell.deleteButton addTarget:self action:@selector(deleteTheSearchCell:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else{
        RentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (cell == nil) {
            cell = [[RentCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
        }
        CGRect rect = CGRectMake(0, 0, 0, 0);
        float w = WindowWidth;
        float h = (WindowHeight - 64) * 11 / 54;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == _rentDataArray.count) {
            cell.otherButton.tag = 680001;
            [cell.otherButton setTitle:@"添加常租放车位" forState:UIControlStateNormal];
            [cell.otherButton addTarget:self action:@selector(cellOtherButttonViewController:) forControlEvents:UIControlEventTouchUpInside];
            cell.otherButton.frame = CGRectMake(w / 4, h / 4, w / 2, h / 2);
            cell.addressLabel.frame = rect;
            cell.timeLabel.frame = rect;
            cell.startButton.frame = rect;
            cell.typePark.frame = rect;
            cell.deleteButton.frame = rect;
        }else if (indexPath.row < _rentDataArray.count){
            cell.otherButton.frame = rect;
            cell.addressLabel.frame = CGRectMake(w / 32, h / 12, w * 23 / 32, h * 3 / 6);
            cell.typePark.frame = CGRectMake(w / 32, CGRectGetMaxY(cell.addressLabel.frame), w * 10 / 32, h * 2 / 6);
            cell.timeLabel.frame = CGRectMake(CGRectGetMaxX(cell.typePark.frame), CGRectGetMaxY(cell.addressLabel.frame), w * 13 / 32, h * 2 / 6);
            cell.startButton.frame = CGRectMake(w * 25 / 32, h / 9, w * 6 / 32, h / 3);
            cell.deleteButton.frame = CGRectMake(w * 25 / 32, h * 5 / 9, w * 6 / 32, h / 3);
            RentParkModel * model = _rentDataArray[indexPath.row];
            cell.addressLabel.text = model.specificLoc;
            NSString * parkStye;
            NSString * price;
            if ([model.priceType integerValue] == 0) {
                price = [NSString stringWithFormat:@"每次：%@元",model.price];
            }else{
                price = [NSString stringWithFormat:@"每小时：%@元",model.price];
            }
            if ([model.spaceType integerValue] == 0) {
                parkStye = [NSString stringWithFormat:@"临时卡"];
            }else{
                parkStye = [NSString stringWithFormat:@"月卡"];
            }
            cell.typePark.text = [NSString stringWithFormat:@"类型：%@",parkStye];
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",price];
            cell.startButton.tag = 1900 + indexPath.row;
            [cell.startButton setTitle:@"租放" forState:UIControlStateNormal];
            [cell.startButton addTarget:self action:@selector(rentCellButton:) forControlEvents:UIControlEventTouchUpInside];
            cell.deleteButton.tag = 1900 + indexPath.row;
            [cell.deleteButton addTarget:self action:@selector(deleteTheRentCell:) forControlEvents:UIControlEventTouchUpInside];

        }
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (WindowHeight - 64) * 11 / 54;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _SearchTabelView) {
        if (_searchDataArray.count > 3) {
            return 3;
        }else{
            if (_searchDataArray.count < 3) {
                return _searchDataArray.count + 1;
            }else{
                return _searchDataArray.count;
            }
        }
    }else{
        if (_rentDataArray.count > 3) {
            return 3;
        }else{
            if (_rentDataArray.count < 3) {
                return _rentDataArray.count + 1;
            }else{
                return _rentDataArray.count;
            }
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return WindowHeight / 18;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == _SearchTabelView) {
        return @"常找车位";
    }else{
        return @"常租放车位";
    }
}
#pragma mark -- UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int commoc = scrollView.contentOffset.x / WindowWidth;
    if (commoc == 0) {
        [self changeRightItem:@"0"];
        _chooseSegementControl.selectedSegmentIndex = 0;
    }
    if (commoc == 1) {
        [self changeRightItem:@"1"];
        _chooseSegementControl.selectedSegmentIndex = 1;
    }
}
#pragma mark -- segment action
-(void)chooseType:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        self.addRentButton.tag = 567000;
        [self changeRightItem:@"0"];
        [self.addRentButton setTitle:@"找其他车位" forState:UIControlStateNormal];
        [_baseScrollView setContentOffset:CGPointMake(0, -64) animated:YES];
        [self httpsDiscoverPark];
    }else{
        [self changeRightItem:@"1"];
        self.addRentButton.tag = 678000;
        [self.addRentButton setTitle:@"增加其他车位" forState:UIControlStateNormal];
        [_baseScrollView setContentOffset:CGPointMake(WindowWidth, -64) animated:YES];
        [self httpsLosserPark_space];
    }
}
#pragma mark -- HTTPS
//放租的车位
-(void)httpsLosserPark_space{
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager GET:[NSString listOftenPark:self.baseInfo.myUid httpsUrl:self.baseInfo.myURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideHud];
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"]integerValue] == 0) {
            [_rentDataArray removeAllObjects];
            NSArray * arr = [dic objectForKey:@"data"];
            for (NSDictionary * dicNew in arr) {
                RentParkModel * model = [[RentParkModel alloc]init];
                [model setValuesForKeysWithDictionary:dicNew];
                [_rentDataArray addObject:model];
            }
            NSArray * arrayUser = [[NSArray alloc]initWithArray:arr];
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:arrayUser];
            [_userDefaults setObject:data forKey:@"rentHttpsData"];
            [_userDefaults synchronize];
        }
        [_RentTabelView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//要找的车位
-(void)httpsDiscoverPark{
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager GET:[NSString searchOftenPark:self.baseInfo.myUid httpsUrl:self.baseInfo.myURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self hideHud];
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            [_searchDataArray removeAllObjects];
            NSArray * arr = [dic objectForKey:@"data"];
            for (NSDictionary * dicNew in arr) {
                SearchParkModel * model = [[SearchParkModel alloc]init];
                [model setValuesForKeysWithDictionary:dicNew];
                [_searchDataArray addObject:model];
            }
            NSArray * arrayUser = [[NSArray alloc]initWithArray:arr];
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:arrayUser];
            [_userDefaults setObject:data forKey:@"searchHttpsData"];
            [_userDefaults synchronize];
        }
        [_SearchTabelView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//删除常租放车位
-(void)deleteRentParking:(NSString *)spaceID{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager DELETE:[NSString cleanPark:spaceID httpsUrl:self.baseInfo.myURL] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            [_RentTabelView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        L1(error);
    }];
}
//删除常找车位
-(void)deleteSearchParking:(NSString *)addresssID{
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager DELETE:[NSString deleteOneOftenPark:addresssID httpsUrl:self.baseInfo.myURL] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
//        L1(dic);
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
        }
        [_SearchTabelView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        L1(error);
    }];
}
#pragma mark -- 删除数据
-(void)deleteTheRentCell:(UIButton *)sender{
    RentParkModel * model = _rentDataArray[sender.tag - 1900];
    [self deleteRentParking:model.spaceId];
    [_rentDataArray removeObject:_rentDataArray[sender.tag - 1900]];
}
-(void)deleteTheSearchCell:(UIButton *)sender{
    SearchParkModel * model = _searchDataArray[sender.tag - 1900];
    [self deleteSearchParking:model.addressId];
    [_searchDataArray removeObject:_searchDataArray[sender.tag - 1900]];
}
#pragma mark -- 页面之间的跳转
-(void)rentCellButton:(UIButton *)sender{
    NSMutableDictionary * dicS = [[NSMutableDictionary alloc]init];
    RentParkModel * model = _rentDataArray[sender.tag - 1900];
    [dicS setValue:model.parkingAddr forKey:@"parkingAddr"];
    [dicS setValue:model.price forKey:@"price"];
    [dicS setValue:model.priceType forKey:@"priceType"];
    [dicS setValue:model.spaceId forKey:@"spaceId"];
    [dicS setValue:model.spaceType forKey:@"spaceType"];
    [dicS setValue:model.specificLoc forKey:@"specificLoc"];
    NSDictionary * dicP = [[NSDictionary alloc]initWithDictionary:dicS];
    Rent_ParkViewController * rent_park = [[Rent_ParkViewController alloc]init];
    rent_park.actionStr = @"0";
    rent_park.spaceDic = dicP;
    [self.navigationController pushViewController:rent_park animated:YES];
}
-(void)searchCellButton:(UIButton *)sender{
    NSMutableDictionary * dicS = [[NSMutableDictionary alloc]init];
    SearchParkModel * model = _searchDataArray[sender.tag - 1800];
    [dicS setValue:model.parkingAddr forKey:@"parkingAddr"];
    [dicS setValue:model.addressId forKey:@"addressId"];
    [dicS setValue:model.created forKey:@"created"];
    [dicS setValue:model.lat forKey:@"lat"];
    [dicS setValue:model.lng forKey:@"lng"];
    [dicS setValue:model.parkingId forKey:@"parkingId"];
    NSDictionary * dicP = [[NSDictionary alloc]initWithDictionary:dicS];
    
    PublishController * publish = [[PublishController alloc]init];
    publish.publishStr = @"0";
    publish.publishDic = dicP;
    [self.navigationController pushViewController:publish animated:YES];
}
-(void)cellOtherButttonViewController:(UIButton *)sender{
    if (sender.tag == 680001) {
        Rent_ParkViewController * rent_park = [[Rent_ParkViewController alloc]init];
        rent_park.actionStr = @"1";
        [self.navigationController pushViewController:rent_park animated:YES];
    }else{
        PublishController * publish = [[PublishController alloc]init];
        publish.publishStr = @"1";
        [self.navigationController pushViewController:publish animated:YES];
    }
}
-(void)addButtonOther:(UIButton *)sender{
    if (sender.tag == 567000) {
        PublishController * publish = [[PublishController alloc]init];
        publish.publishStr = @"2";
        [self.navigationController pushViewController:publish animated:YES];        
    }else{
        Rent_ParkViewController * rent_park = [[Rent_ParkViewController alloc]init];
        rent_park.actionStr = @"2";
        [self.navigationController pushViewController:rent_park animated:YES];
    }
}
#pragma mark -- 通知修改item
-(void)changeRightItem:(NSString *)rightStr{
    if ([rightStr integerValue] == 0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"menuButtonNotificationTitle" object:self userInfo:@{@"title":@"找车记录"}];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"menuButtonNotificationTitle" object:self userInfo:@{@"title":@"常租放车位"}];
    }
}
#pragma mark -- 扫码
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol * symbol;
    for(symbol in results)
        break;
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"扫描到的信息  %@",symbol.data);
    //扫描到信息跳转界面，显示扫到的信息
    ScanResultController * scan = [[ScanResultController alloc]init];
    [self presentViewController:scan animated:YES completion:nil];
    
}
-(void)lineAnimate:(UIView *)lineView{
    [UIView animateWithDuration:3 animations:^{
        lineView.frame = CGRectMake(WindowWidth / 6, WindowHeight * 3 / 5, WindowWidth * 4 / 6, 1);
    } completion:^(BOOL finished) {
        lineView.frame = CGRectMake(WindowWidth / 6, WindowHeight / 5, WindowWidth * 4 / 6, 1);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
