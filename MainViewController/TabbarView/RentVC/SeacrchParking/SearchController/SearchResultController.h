//
//  SearchResultController.h
//  CheWei
//
//  Created by shenyang on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchResultController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView * resultTableView;
@property(nonatomic,strong) NSDictionary * dataDic;
@property(nonatomic,strong) UIView * windowView;/**<确认支付发view*/


/**
 *  查看地图
 */
-(void)inspectMap;
/**
 *  确认租赁
 */
-(void)resultButtonThePark;
/**
 *  下一个
 */
-(void)nextButtonParkMessage;
/**
 *  跳转到选择支付方式
 */
-(void)moneyButtonForPay;
/**
 *  取消支付
 */
-(void)cleanButtonTheView;
@end
