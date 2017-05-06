//
//  UIView+Shake.h
//  CheWei
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shake)
/**
 *  左右抖动效果动画
 *
 *  @param shakeView 抖动的view
 */
-(void)shakeLeftAndRight:(UIView *)shakeView;
/**
 *  上下抖动的动画
 *
 *  @param shakeView 抖动的view
 */
-(void)shakeUpAndDown:(UIView *)shakeView;
@end
