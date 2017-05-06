//
//  TabBarView+views.h
//  CheWei
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TabBarView.h"

@interface TabBarView (views)
/**
 *  tabbar的设置
 */
-(void)loadMyView;
/**
 *  左右2个按钮
 */
-(void)baseButtons;
/**
 *  刚进入时右边按钮显示的文字
 */
-(void)changeButtonTitle:(NSString *)titleStr;
@end
