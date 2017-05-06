//
//  MapAddressController.m
//  CheWei
//
//  Created by shenyang on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MapAddressController.h"

@interface MapAddressController ()<BMKMapViewDelegate>{
    BMKMapView * _mapView;
}

@end

@implementation MapAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
    _mapView.zoomLevel = 18;
    [self.view addSubview:_mapView];
    NSArray * array = [_mapDaic objectForKey:@"data"];
    if (array.count > 0) {
        NSDictionary * dataDic = array[0];
        BMKPointAnnotation * point = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [[dataDic objectForKey:@"lat"] floatValue];
        coor.longitude = [[dataDic objectForKey:@"lng"] floatValue];
        point.coordinate = coor;
        point.title = [dataDic objectForKey:@"parkingAddr"];
        point.subtitle = [dataDic objectForKey:@"parkingAddr"];
        NSLog(@"title == %@",[dataDic objectForKey:@"parkingAddr"]);
        _mapView.centerCoordinate = coor;
        [_mapView addAnnotation:point];
    }
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
       if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
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
