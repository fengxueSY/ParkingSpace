//
//  ScanResultController.h
//  CheWei
//
//  Created by shenyang on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface ScanResultController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * scanResultTableView;


/**
 *  进场
 */
-(void)addendantConfirmEntering;
/**
 *  离场
 */
-(void)addendantConfirmLeaving;
@end
