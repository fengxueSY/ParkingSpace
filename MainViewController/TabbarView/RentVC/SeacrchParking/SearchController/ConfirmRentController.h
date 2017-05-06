//
//  ConfirmRentController.h
//  CheWei
//
//  Created by shenyang on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface ConfirmRentController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * confirmTableView;
@property (nonatomic,strong) NSMutableDictionary * payDic;
/**
 *  支付
 */
-(void)payButtonForPark;
@end
