//
//  UIView+Shake.m
//  CheWei
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+Shake.h"

@implementation UIView (Shake)
-(void)shakeLeftAndRight:(UIView *)shakeView{
    CGFloat t = 3.0;
    //左右抖动效果
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    
    shakeView.transform = translateLeft;
    
    [UIView animateWithDuration:0.08 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:3.0];
        shakeView.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.8 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                shakeView.transform = CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];

}
-(void)shakeUpAndDown:(UIView *)shakeView{
    CGFloat t = 2.0;
    
    //上下抖动效果
    CGAffineTransform translateMiddle  = CGAffineTransformTranslate(CGAffineTransformIdentity, 0.0,t);
    CGAffineTransform translateTop = CGAffineTransformTranslate(CGAffineTransformIdentity,0.0,-t);
    
    shakeView.transform = translateMiddle;
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        
        [UIView setAnimationRepeatCount:1.0];
        shakeView.transform = translateTop;
        
    } completion:^(BOOL finished){
        if(finished){
            
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                shakeView.transform =CGAffineTransformIdentity;
                
            } completion:NULL];
        }
    }];
}
@end
