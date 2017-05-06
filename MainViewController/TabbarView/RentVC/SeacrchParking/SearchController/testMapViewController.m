//
//  testMapViewController.m
//  CheWei
//
//  Created by shenyang on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "testMapViewController.h"

@interface testMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITextFieldDelegate>{
    BMKMapView * testap;
    UITextField * _addressTextField;
    UIButton * _TButton;
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

@implementation testMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userInformation = [[NSMutableDictionary alloc]init];
    self.title = @"从地图中选择位置";
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = left;

    _locationSercive = [[BMKLocationService alloc]init];
    _locationSercive.delegate = self;
    [_locationSercive startUserLocationService];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    
    testap = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight / 2)];
    testap.scrollEnabled = YES;
    testap.zoomEnabledWithTap = YES;
    testap.showsUserLocation = YES;
    testap.zoomLevel = 18;
    testap.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    [self.view addSubview:testap];
    
    _addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(WindowWidth / 64, CGRectGetMaxY(testap.frame) + WindowHeight / 30, WindowWidth * 62 / 64, WindowHeight / 13)];
    _addressTextField.adjustsFontSizeToFitWidth = YES;
    _addressTextField.minimumFontSize = 10;
    _addressTextField.delegate = self;
    _addressTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_addressTextField];
    
    _TButton = [CreatUI creatButtonWithTitle:@"确定" TitleColor:[UIColor blueColor] Frame:CGRectMake(WindowWidth / 64, CGRectGetMaxY(_addressTextField.frame) + WindowHeight / 30, WindowWidth * 62 / 64, WindowHeight / 14) SetMasks:YES SetCorner:10 BackgroudColor:[UIColor greenColor] BackgroudImage:nil];
    [_TButton addTarget:self action:@selector(backAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_TButton];
}
-(void)viewWillAppear:(BOOL)animated{
    [testap viewWillAppear];
    testap.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [testap viewWillDisappear];
    testap.delegate = nil;
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [testap updateLocationData:userLocation];
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
    [testap addAnnotation:pointAnnotation];
    
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
        _addressTextField.text = addressName;
        [userInformation setValue:addressName forKey:@"parkingAddr"];
        [userInformation setValue:result.businessCircle forKey:@"businessCircle"];
        NSString * latitude = [NSString stringWithFormat:@"%f",result.location.latitude];
        NSString * longitude = [NSString stringWithFormat:@"%f",result.location.longitude];
        [userInformation setValue:latitude forKey:@"latitude"];
        [userInformation setValue:longitude forKey:@"longitude"];
    }
}

#pragma mark -- textFiled delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _addressTextField.frame = CGRectMake(WindowWidth / 64, 0, WindowWidth * 62 / 64, WindowHeight / 13);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_addressTextField resignFirstResponder];
    _addressTextField.frame = CGRectMake(WindowWidth / 64, CGRectGetMaxY(testap.frame) + WindowHeight / 30, WindowWidth * 62 / 64, WindowHeight / 13);
    return YES;
}
-(void)backAddress{
    [userInformation setValue:_addressTextField.text forKey:@"parkingAddr"];
    if (_delegate) {
        [_delegate publish_mapAddress:userInformation];
    }
    [self back];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
