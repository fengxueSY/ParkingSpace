//
//  Rent_parkIDController.h
//  CheWei
//
//  Created by shenyang on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@protocol Rent_prakIDControllerDelegate <NSObject>

-(void)writeAddressParkID:(NSDictionary *)parkDic;

@end
@interface Rent_parkIDController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,BMKMapViewDelegate>
@property(nonatomic,assign) id <Rent_prakIDControllerDelegate>delegate;
@property(nonatomic,strong) UITableView * parkIDTabelView;
@property(nonatomic,strong) UITextField * writeTextFiled;
@property(nonatomic,strong) BMKMapView * parkMapView;
@property(nonatomic,copy) NSString * parkIDFromWhere;/**<标记是从哪个界面来的，0从找车位界面，不一定能找到ID,1从租放车位界面，一定能找到ID*/
/**
 *  返回上一界面
 */
-(void)back;
/**
 *  返回选择的数据
 */
-(void)writeTextField;
@end
