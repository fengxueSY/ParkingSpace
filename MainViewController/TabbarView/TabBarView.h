//
//  TabBarView.h
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderView.h"
#import "PersoanlController.h"
#import "MessageController.h"
#import "RentSearchController.h"
@interface TabBarView : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>
@property(nonatomic,strong)UIButton * newsButton;
@property(nonatomic,strong)UIButton * menuButton;
@property(nonatomic,strong)UserInfo * info;
@property(nonatomic,strong)UIView * parkMessageView;
@property(nonatomic,strong) UIView * windowView;/**<确认支付发view*/

/**
 *  删除提示信息
 */
-(void)deleteParkMessageView;
/**
 *  确认租赁
 */
-(void)confirmButtonParkAddress;
/**
 *  查看详情
 */
-(void)detailsButtonParkMessage;
/**
 *  下一个推送
 */
-(void)nextButtonParkMessage;
/**
 *  选择支付方式
 */
-(void)moneyButtonForPayBar;
@end
