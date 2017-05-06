//
//  PersoanlController.h
//  CheWei
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersoanlController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * personalTableView;
@property(nonatomic,strong)NSArray * dataTitle;
@property(nonatomic,strong)NSArray * messageData;

@property(nonatomic,strong)NSString * role;/**<不同的身份*/
@end
