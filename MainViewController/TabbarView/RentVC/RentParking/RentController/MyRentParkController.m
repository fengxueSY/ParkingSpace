//
//  MyRentParkController.m
//  CheWei
//
//  Created by shenyang on 16/4/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyRentParkController.h"
#import "MyRentParkController+creatUI.h"
#import "MyRentParkCell.h"
#import "Rent_ParkViewController.h"
#import "rent_list.h"

@interface MyRentParkController (){
    NSMutableArray * _dataArray;
}

@end

@implementation MyRentParkController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]init];
    [self httpsData];
     self.title = @"我的车位";
    [self creatBaseUI];
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStyleBordered target:self action:@selector(addMyPark)];
    self.navigationItem.rightBarButtonItem = right;
}
#pragma mark -- tableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyRentParkCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[MyRentParkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArray.count > 0) {
        rent_list * rent = _dataArray[indexPath.row];
        cell.nameLabel.text = [NSString stringWithFormat:@"联系人：%@",rent.contactName];
        cell.phoneLabel.text = [NSString stringWithFormat:@"电话：%@",rent.contactPhone];
        if ([rent.spaceType intValue] == 1) {
            cell.typeLabel.text = @"月卡";
        }else{
            cell.typeLabel.text = @"临时卡";
        }
        cell.addressLabel.text = [NSString stringWithFormat:@"地址：%@",rent.specificLoc];
        if ([rent.priceType intValue] == 0) {
            cell.priceLabel.text = [NSString stringWithFormat:@"每次%@元",rent.price];
        }else{
            cell.priceLabel.text = [NSString stringWithFormat:@"每小时%@元",rent.price];
        }
        cell.publishButton.tag = 98000 + indexPath.row;
        [cell.publishButton addTarget:self action:@selector(publishButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.editorButton.tag = 97000 + indexPath.row;
        [cell.editorButton addTarget:self action:@selector(editorButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.cleanButton.tag = 96000 + indexPath.row;
        [cell.cleanButton addTarget:self action:@selector(cleanButton:) forControlEvents:UIControlEventTouchUpInside];
        if ([rent.isFrequent intValue] == 0) {
            [cell.oftenButton setTitle:@"设置" forState:UIControlStateNormal];
        }else{
            [cell.oftenButton setTitle:@"取消" forState:UIControlStateNormal];
        }
        cell.oftenButton.tag = 95000 + indexPath.row;
        [cell.oftenButton addTarget:self action:@selector(oftenButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
#pragma mark -- HTTPS
-(void)httpsData{
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager GET:[NSString listAllRentPark:self.baseInfo.myUid httpsUrl:self.baseInfo.myURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            NSArray * dataArray = [dic objectForKey:@"data"];
            for (NSDictionary * listDic in dataArray) {
                rent_list * rent = [[rent_list alloc]init];
                [rent setValuesForKeysWithDictionary:listDic];
                [_dataArray addObject:rent];
            }
            [_displayTableView reloadData];
        }
//        NSLog(@"请求成功，请求%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        L1(error);
    }];
}
//跳转到增加常用车位
-(void)addMyPark{
    Rent_ParkViewController * ren = [[Rent_ParkViewController alloc]init];
    ren.actionStr = @"1";
    [self.navigationController pushViewController:ren animated:YES];
}
//设置为常用车位
-(void)oftenButton:(UIButton *)sender{
    rent_list * list = _dataArray[sender.tag - 95000];
    NSIndexPath * index = [NSIndexPath indexPathForRow:sender.tag - 95000 inSection:0];
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    NSNumber * isFre;
    if ([list.isFrequent intValue] == 0) {
        isFre = [NSNumber numberWithInt:1];
    }else{
        isFre = [NSNumber numberWithInt:0];
    }
    NSDictionary * dic0 = @{@"uid":self.baseInfo.myUid,@"spaceId":list.spaceId,@"isFrequent":isFre};
    [manager PUT:[NSString commonlyUsedPark:list.spaceId httpsUrl:self.baseInfo.myURL] parameters:dic0 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"]integerValue] == 0) {
            if ([list.isFrequent intValue]== 1) {
                list.isFrequent = @"0";
                [_dataArray replaceObjectAtIndex:sender.tag - 95000 withObject:list];
            }else{
                list.isFrequent = @"1";
                [_dataArray replaceObjectAtIndex:sender.tag - 95000 withObject:list];
            }
            
            [_displayTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//编辑车位信息
-(void)editorButton:(UIButton *)sender{
    Rent_ParkViewController * rent = [[Rent_ParkViewController alloc]init];
    rent.actionStr = @"1";
    rent_list * list = _dataArray[sender.tag - 97000];
    NSMutableDictionary * spacD = [[NSMutableDictionary alloc]init];
    if (list.contactName != nil) {
        [spacD setValue:list.contactName forKey:@"contactName"];
    }
    if (list.contactPhone != nil) {
        [spacD setValue:list.contactPhone forKey:@"contactPhone"];
    }
    if (list.spaceId != nil) {
        [spacD setValue:list.spaceId forKey:@"spaceId"];
    }
    if (list.spaceType != nil) {
        [spacD setValue:list.spaceType forKey:@"spaceType"];
    }
    if (list.specificLoc != nil) {
        [spacD setValue:list.specificLoc forKey:@"specificLoc"];
    }
    if (list.isFrequent != nil) {
        [spacD setValue:list.isFrequent forKey:@"isFrequent"];
    }
    if (list.parkingAddr != nil) {
        [spacD setValue:list.parkingAddr forKey:@"parkingAddr"];
    }
    if (list.price != nil) {
        [spacD setValue:list.price forKey:@"price"];
    }
    if (list.priceType != nil) {
        [spacD setValue:list.priceType forKey:@"priceType"];
    }
    NSDictionary * dic = [[NSDictionary alloc]initWithDictionary:spacD];
    rent.spaceDic = dic;
    [self.navigationController pushViewController:rent animated:YES];
}
//删除车位信息
-(void)cleanButton:(UIButton *)sender{
    rent_list * list = _dataArray[sender.tag - 96000];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    [manager DELETE:[NSString cleanPark:list.spaceId httpsUrl:self.baseInfo.myURL] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            [_dataArray removeObject:_dataArray[sender.tag - 96000]];
            [_displayTableView reloadData];
        }
//        NSLog(@"删除某一车位  %@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        L1(error);
    }];
}
//发布车位
-(void)publishButton:(UIButton *)sender{
    Rent_ParkViewController * rent = [[Rent_ParkViewController alloc]init];
    rent.actionStr = @"0";
    rent_list * list = _dataArray[sender.tag - 98000];
    NSMutableDictionary * spacD = [[NSMutableDictionary alloc]init];
    if (list.contactName != nil) {
        [spacD setValue:list.contactName forKey:@"contactName"];
    }
    if (list.contactPhone != nil) {
        [spacD setValue:list.contactPhone forKey:@"contactPhone"];
    }
    if (list.spaceId != nil) {
        [spacD setValue:list.spaceId forKey:@"spaceId"];
    }
    if (list.spaceType != nil) {
        [spacD setValue:list.spaceType forKey:@"spaceType"];
    }
    if (list.specificLoc != nil) {
        [spacD setValue:list.specificLoc forKey:@"specificLoc"];
    }
    if (list.isFrequent != nil) {
        [spacD setValue:list.isFrequent forKey:@"isFrequent"];
    }
    if (list.parkingAddr != nil) {
        [spacD setValue:list.parkingAddr forKey:@"parkingAddr"];
    }
    if (list.price != nil) {
        [spacD setValue:list.price forKey:@"price"];
    }
    if (list.priceType != nil) {
        [spacD setValue:list.priceType forKey:@"priceType"];
    }
    NSDictionary * dic = [[NSDictionary alloc]initWithDictionary:spacD];
    rent.spaceDic = dic;
    [self.navigationController pushViewController:rent animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
