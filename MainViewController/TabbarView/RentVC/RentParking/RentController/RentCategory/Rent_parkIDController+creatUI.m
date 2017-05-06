//
//  Rent_parkIDController+creatUI.m
//  CheWei
//
//  Created by shenyang on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Rent_parkIDController+creatUI.h"

@implementation Rent_parkIDController (creatUI)
-(void)creatBaseaUI{
    UIBarButtonItem * let = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(writeTextField)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.leftBarButtonItem = let;
    
    self.parkMapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight / 2)];
    self.parkMapView.scrollEnabled = YES;
    self.parkMapView.zoomEnabledWithTap = YES;
    self.parkMapView.showsUserLocation = YES;
    self.parkMapView.zoomLevel = 18;
    self.parkMapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    self.parkMapView.delegate = self;
    [self.view addSubview:self.parkMapView];
    
    self.writeTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(WindowWidth / 64, CGRectGetMaxY(self.parkMapView.frame) + WindowHeight / 15, WindowWidth * 62 / 64, WindowHeight / 13)];
    self.writeTextFiled.delegate = self;
    self.writeTextFiled.adjustsFontSizeToFitWidth = YES;
    self.writeTextFiled.minimumFontSize = 10;
    self.writeTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    self.writeTextFiled.keyboardType = UIKeyboardTypeWebSearch;
    [self.view addSubview:self.writeTextFiled];
    
    self.parkIDTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.writeTextFiled.frame) + WindowHeight / 15, WindowWidth, WindowHeight - CGRectGetMaxY(self.writeTextFiled.frame) + WindowHeight / 15)];
    self.parkIDTabelView.delegate = self;
    self.parkIDTabelView.dataSource = self;
    self.parkIDTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.parkIDTabelView];
}
@end
