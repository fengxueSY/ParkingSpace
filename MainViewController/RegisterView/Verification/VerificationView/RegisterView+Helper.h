//
//  RegisterView+Helper.h
//  CheWei
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterView.h"

@interface RegisterView (Helper)
/**
 *  输入框
 */
-(void)loadingMyView;
/**
 *  输入框颜色变化
 */
-(void)changeColor:(NSUInteger)sender;
/**
 *  注册需要加载的界面
 */
-(void)fromRegister;
@end
