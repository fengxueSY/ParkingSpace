//
//  SearchRecordController.h
//  CheWei
//
//  Created by shenyang on 16/4/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchRecordController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (nonatomic,strong) UITableView * recordTableView;
@end
