//
//  TabBarView+parkMessage.h
//  CheWei
//
//  Created by shenyang on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TabBarView.h"

@interface TabBarView (parkMessage)
/**
 *  显示车场信息的view
 */
-(void)creatParkMessageView:(NSDictionary *)parkMessageDic;
/**
 *  确认支付的弹窗
 */
-(void)resultWindow:(NSDictionary *)priceDic;

@end
