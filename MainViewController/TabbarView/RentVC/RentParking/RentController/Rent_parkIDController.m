//
//  Rent_parkIDController.m
//  CheWei
//
//  Created by shenyang on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Rent_parkIDController.h"
#import "Rent_parlIDCell.h"
#import "Rent_parkID.h"
#import "Rent_parkIDController+creatUI.h"

@interface Rent_parkIDController ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    NSMutableArray * _dataArray;//数据源
    NSMutableDictionary * parkIDStr;
    
    BMKLocationService * _locationSercive;
    BMKPointAnnotation* pointAnnotation;
    CLLocationCoordinate2D pt;
    BMKGeoCodeSearch* _geocodesearch;
    BMKPinAnnotationView * annotationView;
    NSString* titleStr;
    NSString* showmeg;
    NSString * addressName;
    NSMutableDictionary * userInformation;
}

@end

@implementation Rent_parkIDController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"选择车场的位置";
    parkIDStr = [[NSMutableDictionary alloc]init];
    _dataArray = [[NSMutableArray alloc]init];
    [self baiduMapView];
    [self creatBaseaUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [_parkMapView viewWillAppear];
    _parkMapView.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [_parkMapView viewWillDisappear];
    _parkMapView.delegate = nil;
}
#pragma mark -- 百度地图
-(void)baiduMapView{
    _locationSercive = [[BMKLocationService alloc]init];
    _locationSercive.delegate = self;
    [_locationSercive startUserLocationService];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_parkMapView updateLocationData:userLocation];
}
-(void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    pt = (CLLocationCoordinate2D){coordinate.latitude, coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag){
        
    }else{
        
    }
    pointAnnotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = coordinate.latitude;
    coor.longitude = coordinate.longitude;
    pointAnnotation.coordinate = coor;
    pointAnnotation.subtitle = addressName;
    [_parkMapView addAnnotation:pointAnnotation];
    
}
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    NSString *AnnotationViewID = @"renameMark";
    if (annotationView) {
        [annotationView removeFromSuperview];
    }
    annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    // 设置颜色
    annotationView.pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
    annotationView.animatesDrop = YES;
    annotationView.draggable = NO;
    annotationView.canShowCallout = addressName;
    return annotationView;
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        addressName = result.address;
        _writeTextFiled.text = addressName;
        [self parkAddressId:_writeTextFiled.text];
//        [userInformation setValue:addressName forKey:@"parkingAddr"];
//        [userInformation setValue:result.businessCircle forKey:@"businessCircle"];
//        NSString * latitude = [NSString stringWithFormat:@"%f",result.location.latitude];
//        NSString * longitude = [NSString stringWithFormat:@"%f",result.location.longitude];
//        [userInformation setValue:latitude forKey:@"latitude"];
//        [userInformation setValue:longitude forKey:@"longitude"];
    }
}

#pragma mark -- tabelView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WindowHeight / 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Rent_parlIDCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[Rent_parlIDCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Rent_parkID * rentId = _dataArray[indexPath.row];
    cell.parkAddress.text = rentId.parkingAddr;
    cell.latitudeLabel.text = [NSString stringWithFormat:@"纬度：%.2f",[rentId.lat floatValue]];
    cell.longitudeLabel.text = [NSString stringWithFormat:@"经度：%.2f",[rentId.lng floatValue]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Rent_parkID * rentID = _dataArray[indexPath.row];
    _writeTextFiled.text = rentID.parkingAddr;
    [parkIDStr setValue:rentID.parkingAddr forKey:@"parkingAddr"];
    [parkIDStr setValue:rentID.parkingId forKey:@"parkingID"];
    [parkIDStr setValue:rentID.lat forKey:@"lat"];
    [parkIDStr setValue:rentID.lng forKey:@"lng"];
}
#pragma mark -- textField delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self parkAddressId:str];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.writeTextFiled.frame = CGRectMake(WindowWidth / 64, WindowHeight / 15, WindowWidth * 62 / 64, WindowHeight / 13);
    self.parkIDTabelView.frame = CGRectMake(0, CGRectGetMaxY(self.writeTextFiled.frame) + WindowHeight / 15, WindowWidth, WindowHeight - CGRectGetMaxY(self.writeTextFiled.frame) + WindowHeight / 15);
    self.parkIDTabelView.backgroundColor = [UIColor clearColor];
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.writeTextFiled.frame = CGRectMake(WindowWidth / 64, CGRectGetMaxY(self.parkMapView.frame) + WindowHeight / 15, WindowWidth * 62 / 64, WindowHeight / 13);
    self.parkIDTabelView.frame = CGRectMake(0, CGRectGetMaxY(self.writeTextFiled.frame) + WindowHeight / 15, WindowWidth, WindowHeight - CGRectGetMaxY(self.writeTextFiled.frame) + WindowHeight / 15);
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length > 0) {
        self.writeTextFiled.frame = CGRectMake(WindowWidth / 64, CGRectGetMaxY(self.parkMapView.frame) + WindowHeight / 15, WindowWidth * 62 / 64, WindowHeight / 13);
        self.parkIDTabelView.frame = CGRectMake(0, CGRectGetMaxY(self.writeTextFiled.frame) + WindowHeight / 15, WindowWidth, WindowHeight - CGRectGetMaxY(self.writeTextFiled.frame) + WindowHeight / 15);
        [_writeTextFiled resignFirstResponder];
        [self parkAddressId:textField.text];
    }else{
        TTAlert1(@"请输入内容", self);
    }
    return YES;
}
#pragma mark -- HTTPS
-(void)parkAddressId:(NSString *)parkAddress{
   
    AFHTTPSessionManager * manager = [AFN_DayI requestWithoutHeader_JSON];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",self.baseInfo.myToken] forHTTPHeaderField:@"Authorization"];
    NSDictionary * dic0 = @{@"address":parkAddress,@"uid":self.baseInfo.myUid};
    [manager POST:[NSString obtainParkID:self.baseInfo.myURL] parameters:dic0 progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [SB_DayI analysisMessage:responseObject];
//        NSLog(@"获取车站id  %@",dic);
        if ([[dic objectForKey:@"code"] integerValue] == 0) {
            [_dataArray removeAllObjects];
            NSArray * array = [dic objectForKey:@"data"];
            for (NSDictionary * listDic in array) {
                Rent_parkID * parkID = [[Rent_parkID alloc]init];
                [parkID setValuesForKeysWithDictionary:listDic];
                [_dataArray addObject:parkID];
            }
            [_parkIDTabelView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}
-(void)writeTextField{
    if (_delegate) {
        if (parkIDStr.count > 0) {
            if ([_parkIDFromWhere integerValue] == 0) {
                if (_dataArray.count > 0) {
                    NSDictionary * dic = [[NSDictionary alloc]initWithDictionary:parkIDStr];;
                    [_delegate writeAddressParkID:dic];
                }else{
                    NSDictionary * dic = @{@"parkingAddr":_writeTextFiled.text};
                    [_delegate writeAddressParkID:dic];
                }
            }else{
                NSDictionary * dic = [[NSDictionary alloc]initWithDictionary:parkIDStr];;
                [_delegate writeAddressParkID:dic];
            }
        }else{
            if (_writeTextFiled.text.length > 0 && _dataArray.count > 0) {
                Rent_parkID * rentId = _dataArray[0];
                NSDictionary * dic = @{@"parkingAddr":rentId.parkingAddr,@"parkingID":rentId.parkingId,@"lat":rentId.lat,@"lng":rentId.lng};
                [_delegate writeAddressParkID:dic];
            }else{
                TTAlert1(@"请输入信息查找", self);
            }
        }
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
