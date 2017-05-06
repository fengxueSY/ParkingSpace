//
//  MessageController.h
//  CheWei
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageController : BaseViewController
@property(nonatomic,strong)UISegmentedControl * typeSengment;
@property(nonatomic,strong)UIScrollView * baseScrollView;
@property(nonatomic,strong)UITableView * findTableView;
@property(nonatomic,strong)UITableView * rentTableView;

@property(nonatomic,strong)UILabel * tipLabel;
@property(nonatomic,strong)UIButton * addButton;

@property(nonatomic,strong)NSMutableArray * findDatasource;
@property(nonatomic,strong)NSMutableArray * rentDatasource;
@end
