/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;
- (void)successShowAndHideHudInView:(UIView *)view hint:(NSString *)hint Delay:(NSTimeInterval)time;/**<成功加载的时候*/
- (void)failShowAndHideHudInView:(UIView *)view hint:(NSString *)hint Delay:(NSTimeInterval)time;/**<加载失败的时候*/
- (void)hideHud;
/**
 *  在中间显示提示语,1秒之后自动消失
 *
 *  @param hint 展示的提示语
 */
- (void)showHint:(NSString *)hint;
- (void)showHeaderHint:(NSString *)hint;
// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;
/**
 *延迟的时间
 */
- (void)showHeaderHint:(NSString *)hint delayTime:(NSTimeInterval)time;
@end
