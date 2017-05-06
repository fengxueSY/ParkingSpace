//
//  SearchResultController+creatUI.h
//  CheWei
//
//  Created by shenyang on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchResultController.h"

@interface SearchResultController (creatUI)
/**
 *  创建基础UI
 */
-(void)creatBaseUI;
/**
 *  确认支付的弹窗
 */
-(void)resultWindow:(NSDictionary *)priceDic;
@end
