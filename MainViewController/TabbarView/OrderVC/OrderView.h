//
//  OrderView.h
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderView : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UISegmentedControl * baseSegment;
@property(nonatomic,strong)UIScrollView * baseScrollView;
@property(nonatomic,strong)UITableView * findTableView;
@property(nonatomic,strong)UITableView * rentTableView;

@property(nonatomic,strong)NSMutableArray * findDatasource;
@property(nonatomic,strong)NSMutableArray * rentDatasource;
@end
