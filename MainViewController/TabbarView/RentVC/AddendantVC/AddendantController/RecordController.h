//
//  RecordController.h
//  CheWei
//
//  Created by shenyang on 16/5/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
@interface RecordController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * recordTableView;
@end
